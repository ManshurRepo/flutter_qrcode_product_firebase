// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
 final String? sku;
  final String? sn;
  final String? code;
  final String? divisi;
  final String? keterangan;
  final String? lisensi;
  final String? lisensi2;
  final String? name;
  final String? posisi;
  final int? qty;
  final String? status;
  final String? expired;
  final String? order;
  final String? receipt;
  AddProduct({
    required this.sku,
    required this.sn,
    required this.code,
    required this.divisi,
    required this.keterangan,
    required this.lisensi,
    required this.lisensi2,
    required this.name,
    required this.posisi,
    required this.qty,
    required this.status,
    required this.expired,
    required this.order,
    required this.receipt,
  });
}

class EditProduct extends ProductEvent {
   final String? sku;
  final String? sn;
  final String? code;
  final String? divisi;
  final String? keterangan;
  final String? lisensi;
  final String? lisensi2;
  final String? name;
  final String? posisi;
  final String? productId;
  final int? qty;
  final String? status;
  final String? expired;
  final String? order;
  final String? receipt;

  EditProduct({
    this.sku,
    this.sn,
    this.code,
    this.divisi,
    this.keterangan,
    this.lisensi,
    this.lisensi2,
    this.name,
    this.posisi,
    this.productId,
    this.qty,
    this.status,
    this.expired,
    this.order,
    this.receipt,
  });
}

class DeleteProduct extends ProductEvent {
  DeleteProduct(this.id);

  final String id;
}

class ExportProductEventToPdf extends ProductEvent {}
