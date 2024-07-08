part of 'auth_bloc_bloc.dart';

@freezed
class AuthBlocEvent with _$AuthBlocEvent {
  const factory AuthBlocEvent.started() = _Started;
  const factory AuthBlocEvent.register(AuthRegisterRequestModel data) = _Register;
}