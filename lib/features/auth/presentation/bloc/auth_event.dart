part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent(
      {required this.password, required this.authType, required this.username});

  final String password;
  final String username;
  final String authType;

  @override
  List<Object?> get props => <Object?>[password, authType, username];
}
