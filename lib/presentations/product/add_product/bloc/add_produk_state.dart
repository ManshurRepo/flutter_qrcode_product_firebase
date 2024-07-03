part of 'add_produk_bloc.dart';

@freezed
class AddProdukState with _$AddProdukState {
const factory AddProdukState.initial() = _Initial;
const factory AddProdukState.loading() = _Loading;
const factory AddProdukState.loaded(AddProductResponseModel model) = _Loaded;
const factory AddProdukState.error(String message) = _Error;

}
