part of 'add_produk_bloc.dart';

@freezed
class AddProdukEvent with _$AddProdukEvent {
  const factory AddProdukEvent.started() = _Started;
  const factory AddProdukEvent.addProduk(ProductRequestModel addProduk) = _AddProduk;

}