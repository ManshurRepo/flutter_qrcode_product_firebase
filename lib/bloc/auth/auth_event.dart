// part of 'auth_bloc.dart';

// abstract class AuthEvent {}

// class AuthEventLogin extends AuthEvent {
//   AuthEventLogin(this.email, this.password);
//   final String email;
//   final String password;
// }

// class AuthEventLogout extends AuthEvent {}

part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin(this.email, this.password);
}

class AuthEventLogout extends AuthEvent {}
