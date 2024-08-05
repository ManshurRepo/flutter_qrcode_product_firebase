// part of 'auth_bloc.dart';

// abstract class AuthState {}

// class AuthStateLogin extends AuthState {}

// class AuthStateLogout extends AuthState {}

// class AuthStateLoading extends AuthState {}

// class AuthStateError extends AuthState {
//   AuthStateError(this.message);
  
//   final String message;
// }
part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateLogin extends AuthState {
  final String idToken;

  AuthStateLogin(this.idToken);
}

class AuthStateLogout extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}
