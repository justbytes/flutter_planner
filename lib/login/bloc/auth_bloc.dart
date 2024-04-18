import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_planner/login/data/repository/auth_repository.dart';
import 'package:flutter_planner/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<UserModel> userSubscription;

  AuthBloc(this.authRepository)
      : super(authRepository.currentUser.isNotEmpty
            ? UserAuthenticated(user: authRepository.currentUser)
            : AuthInitial()) {
    // Send login request
    //
    on<_AuthUserChanged>(_onUserChanged);

    // Send login request
    //
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthSignupRequested>(_onAuthSignupRequested);

    // Handle log out request
    //
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }
  // Checks if the user is empty, if not sets the Authentecated state to authed,
  // and sends the current user if not it remains unathed
  //
  void _onUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty
        ? UserAuthenticated(user: event.user)
        : AuthInitial());
  }

  // Login with Email Passowrd
  //
  Future<void> _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final email = event.email;
      final password = event.password;

      User? userCredential = await authRepository.logInWithEmailAndPassword(
          email: email, password: password);

      // if (password.length < 6) {
      //   return emit(AuthFailure(
      //       "Password is to short. Must be at least 6 characters."));
      // }

      return emit(AuthSuccess(user: userCredential));
    } on Exception catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthSignupRequested(
      AuthSignupRequested event, Emitter<AuthState> emit) async {
    try {
      final email = event.email;
      final password = event.password;
      final username = event.username;

      print("EMAIL $email, PASSWORD $password, USERNAME $username");

      User? userCredential = await authRepository.signUpWithEmailAndPassowrd(
        email: email,
        password: password,
        username: username,
      );
      return emit(AuthSuccess(user: userCredential));
    } on Exception catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  // Handle log out
  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      unawaited(authRepository.logOut());
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
    @override
    Future<void> close() {
      userSubscription.cancel();
      return super.close();
    }
  }
}
