part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  AuthStateError(this.message);
  
  final String message;
}
