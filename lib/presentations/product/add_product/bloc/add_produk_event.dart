part of 'add_produk_bloc.dart';

@freezed
class AddProdukEvent with _$AddProdukEvent {
  const factory AddProdukEvent.started() = _Started;
  const factory AddProdukEvent.addProduk(ProductRequestModel addProduk) =
      _AddProduk;
  const factory AddProdukEvent.editProduk(
      int id, EditProductRequestModel editProduk) = _EditProduk;
  const factory AddProdukEvent.deleteProduk(int id) = _DeleteProduk;
}
