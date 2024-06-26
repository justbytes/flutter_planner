part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class _AuthUserChanged extends AuthEvent {
  final UserModel user;
  const _AuthUserChanged(this.user);
}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });
}

final class GoogleLoginRequested extends AuthEvent {}

final class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthSignupRequested({
    required this.email,
    required this.password,
    required this.username,
  });
}

final class AuthLogoutRequested extends AuthEvent {}
