part of 'produk_bloc.dart';

@freezed
class ProdukState with _$ProdukState {
  const factory ProdukState.initial() = _Initial;
  const factory ProdukState.loading() = _Loading;
  const factory ProdukState.loaded(ProductResponseModel model) = _Loaded;
  const factory ProdukState.error(String message) = _Error;




}
