// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:flutter_scanqr/data/models/response/add_product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_scanqr/data/datasources/product_remote_datasource.dart';
import 'package:flutter_scanqr/data/models/request/product_request_model.dart';

import '../../../../data/models/request/edit_product_request_model.dart';

part 'add_produk_bloc.freezed.dart';
part 'add_produk_event.dart';
part 'add_produk_state.dart';

class AddProdukBloc extends Bloc<AddProdukEvent, AddProdukState> {
  final ProductRemoteDatasource productRemoteDatasource;

  AddProdukBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddProduk>(
      (event, emit) async {
        emit(const _Loading());
        final result = await productRemoteDatasource.createProduct(event.addProduk);

        result.fold(
          (l) => emit(AddProdukState.error(l)),
          (r) => emit(AddProdukState.loaded(r)),
        );
      },
    );

    on<_EditProduk>(
      (event, emit) async {
        emit(const _Loading());
        final result = await productRemoteDatasource.updateProduk(event.id, event.editProduk);

        result.fold(
          (l) => emit(AddProdukState.error(l)),
          (r) => emit(AddProdukState.loaded(r)),
        );
      },
    );
  }
}
