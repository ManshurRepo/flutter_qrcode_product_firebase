part of 'auth_bloc_bloc.dart';

@freezed
class AuthBlocState with _$AuthBlocState {
  const factory AuthBlocState.initial() = _Initial;
  const factory AuthBlocState.loading() = _Loading;
  const factory AuthBlocState.loaded(AuthResponseModel authModel) = _Loaded;
  const factory AuthBlocState.error(String message) = _Error;

}
