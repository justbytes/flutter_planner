import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_planner/cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_planner/login/data/repository/auth_failures/log_in_email_pass_failure.dart';
import 'package:flutter_planner/login/data/repository/auth_failures/log_out_failure.dart';
import 'package:flutter_planner/login/data/repository/auth_failures/sign_up_email_pass_failure.dart';
import 'package:flutter_planner/models/user_model.dart';

class AuthRepository {
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    required CacheClient cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = UserModel.empty;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
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

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUpWithEmailAndPassowrd(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<UserCredential> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      return throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
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
    return UserModel(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
