part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  AuthEventLogin(this.email, this.password);
  final String email;
  final String password;
}

class AuthEventLogout extends AuthEvent {}
