import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_planner/cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_planner/models/user_model.dart';
import 'package:flutter_planner/views/authentication/data/repository/auth_failures/log_in_email_pass_failure.dart';
import 'package:flutter_planner/views/authentication/data/repository/auth_failures/log_in_google_failure.dart';
import 'package:flutter_planner/views/authentication/data/repository/auth_failures/log_out_failure.dart';
import 'package:flutter_planner/views/authentication/data/repository/auth_failures/sign_up_email_pass_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepository({
    required CacheClient cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = UserModel.empty;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  /// Emits [User.empty] if the user is not authenticated.
  ///
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user =
            firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
        currentUser = user;
        return user;
      },
    );
  }

/*------------------------- Email and Password Auth ------------------------- */

  /// Creates a new user with the provided [email] and [password].
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  ///
  Future<User?> signUpWithEmailAndPassowrd({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      await user?.updateDisplayName(username);
      await user?.reload();
      User? latestUser = FirebaseAuth.instance.currentUser;

      return latestUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  ///
  Future<User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User? latestUser = FirebaseAuth.instance.currentUser;
      return latestUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      return throw const LogInWithEmailAndPasswordFailure();
    }
  }

/*------------------------------ Social Logins ------------------------------ */

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw LogInWithGoogleFailure(e.toString());
    }
  }

/*--------------------------------- Logout ---------------------------------- */

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  ///
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        GoogleSignIn().signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

/// Maps a [firebase_auth.User] into a [User].
///
extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      username: displayName,
      photo: photoURL,
    );
  }
}
