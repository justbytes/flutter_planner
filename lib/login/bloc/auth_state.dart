// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAuthStatus extends AuthState {
  final AuthStatus status;
  final UserModel user;
  UserAuthStatus(this.status, this.user);

  @override
  String toString() => 'UserAuthStatus(status: $status)';
}

class AuthInitial extends AuthState {
  final AuthStatus status = AuthStatus.unauthenticated;
  AuthInitial();

  @override
  String toString() => 'AuthInitial: $AuthInitial';
}

class UserUnauthenticated extends AuthState {
  final UserModel user;
  final AuthStatus status = AuthStatus.unauthenticated;
  UserUnauthenticated({required this.user});
}

class UserAuthenticated extends AuthState {
  final UserModel user;
  final AuthStatus status = AuthStatus.authenticated;
  UserAuthenticated({required this.user});
}

class AuthSuccess extends AuthState {
  final UserCredential user;
  final AuthStatus status = AuthStatus.authenticated;
  AuthSuccess({required this.user});

  @override
  List<Object?> get props => [status, user];

  @override
  String toString() => 'AuthSuccess: $AuthSuccess';
}

class AuthFailure extends AuthState {
  final String error;
  final AuthStatus status = AuthStatus.unauthenticated;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [status, error];

  @override
  String toString() => 'AuthFailure: $AuthFailure';
}

class AuthLoading extends AuthState {
  AuthLoading();

  @override
  String toString() => 'AuthLoading: $AuthLoading';
}
