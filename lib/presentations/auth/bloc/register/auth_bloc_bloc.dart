import 'package:bloc/bloc.dart';
import 'package:flutter_scanqr/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_scanqr/data/models/request/auth_register_request_model.dart';
import 'package:flutter_scanqr/data/models/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';
part 'auth_bloc_bloc.freezed.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final response = await AuthRemoteDatasource().register(event.data);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
