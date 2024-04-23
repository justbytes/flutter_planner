// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

@immutable
// Auth state handling authentication
//
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// A state that can set the user and their status
// may not be needed
//
class UserAuthStatus extends AuthState {
  final AuthStatus status;
  final UserModel user;
  UserAuthStatus(this.status, this.user);

  @override
  String toString() => 'UserAuthStatus(status: $status)';
}

// Initial state of the AuthState
// status is unauthenticatee
//
class AuthInitial extends AuthState {
  final AuthStatus status = AuthStatus.unauthenticated;
  AuthInitial();

  @override
  String toString() => 'AuthInitial: $AuthInitial';
}

// This might need to be removed
// code should be refactored
// but this is used for conditionals to say if the user
// is unauthenticated or authenticated
//
class UserUnauthenticated extends AuthState {
  final UserModel user;
  final AuthStatus status = AuthStatus.unauthenticated;
  UserUnauthenticated({required this.user});
}

// This might need to be removed
// code should be refactored
// but this is used for conditionals to say if the user
// is unauthenticated or authenticated
//
class UserAuthenticated extends AuthState {
  final UserModel user;
  final AuthStatus status = AuthStatus.authenticated;
  UserAuthenticated({required this.user});
}

// Signals successful auth login
// recieves a user
// status is set to authenticated
//
class AuthSuccess extends AuthState {
  final User? user;
  final AuthStatus status = AuthStatus.authenticated;
  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [status, user];

  @override
  String toString() => 'AuthSuccess: $AuthSuccess';
}

class GoogleSuccess extends AuthState {
  final UserCredential user;
  final AuthStatus status = AuthStatus.authenticated;
  GoogleSuccess({required this.user});

  @override
  List<Object?> get props => [status, user];

  @override
  String toString() => 'GoogleSuccess: $GoogleSuccess';
}

// Signals that there was a Auth related failure
// sets the status to unauthenticated
// displays an error
//
class AuthFailure extends AuthState {
  final String error;
  final AuthStatus status = AuthStatus.unauthenticated;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [status, error];

  @override
  String toString() => 'AuthFailure: $AuthFailure';
}

// Signals that the Auth is in a loading state
//
class AuthLoading extends AuthState {
  AuthLoading();

  @override
  String toString() => 'AuthLoading: $AuthLoading';
}
