// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent {}

class AddProduct extends ProductEvent {
  final String code;
  final String name;
  final int qty;
  AddProduct({
    required this.code,
    required this.name,
    required this.qty,
  });
}

class EditProduct extends ProductEvent {
  final String productId;
  final String name;
  final int qty;

  EditProduct({
    required this.productId,
    required this.name,
    required this.qty,
  });
}

class DeleteProduct extends ProductEvent {
  DeleteProduct(this.id);

  final String id;
}

class ExportProductEventToPdf extends ProductEvent {}


