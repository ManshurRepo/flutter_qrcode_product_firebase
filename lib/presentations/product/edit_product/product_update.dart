import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc_firebase/product/product_bloc.dart';
import 'package:flutter_scanqr/data/models/response/product_model.dart';
import 'package:flutter_scanqr/data/models/response/product_response_model.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/datasources/product_remote_datasource.dart';
import '../../../data/models/request/edit_product_request_model.dart';
import '../../../data/models/request/product_request_model.dart';

class UpdateProductPage extends StatelessWidget {
  UpdateProductPage(this.id, this.produk, {super.key});

  final String id;

  final Produk produk;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController snController = TextEditingController();
  final TextEditingController lisensiController = TextEditingController();
  final TextEditingController lisensi2Controller = TextEditingController();
  final TextEditingController orderController = TextEditingController();
  final TextEditingController receiptController = TextEditingController();
  final TextEditingController expiredController = TextEditingController();
  final TextEditingController posisiController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController divisiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeController.text = produk.kodeProduk;
    nameController.text = produk.namaProduk;
    qtyController.text = produk.jumlahProduk.toString();
    skuController.text = produk.sku;
    snController.text = produk.sn;
    lisensiController.text = produk.lisensi1;
    lisensi2Controller.text = produk.lisensi2;
    orderController.text = produk.tanggalOrder;
    receiptController.text = produk.tanggalExpired;
    expiredController.text = produk.tanggalTerima;
    posisiController.text = produk.posisi;
    statusController.text = produk.status;
    keteranganController.text = produk.keterangan;
    divisiController.text = produk.divisi;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Update Product',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: QrImageView(
                      data: produk.kodeProduk,
                      size: 200,
                      version: QrVersions.auto,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                autocorrect: false,
                controller: codeController,
               
                maxLength: 10,
                decoration: InputDecoration(
                    label: const Text("Kode Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: const Text("Nama Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: const Text("Jumlah Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                maxLength: 10,
                controller: skuController,
                decoration: InputDecoration(
                    labelText: 'SKU',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                maxLength: 25,
                controller: snController,
                decoration: InputDecoration(
                    labelText: 'SN',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                maxLength: 20,
                controller: lisensiController,
                decoration: InputDecoration(
                    labelText: 'Lisensi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                maxLength: 20,
                controller: lisensi2Controller,
                decoration: InputDecoration(
                    labelText: 'Lisensi 2',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: orderController,
                decoration: InputDecoration(
                    labelText: 'Tanggal Order',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: receiptController,
                decoration: InputDecoration(
                    labelText: 'Tanggal Receipt',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: expiredController,
                decoration: InputDecoration(
                    labelText: 'Tanggal Expired',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: posisiController,
                decoration: InputDecoration(
                    labelText: 'Posisi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: divisiController,
                decoration: InputDecoration(
                    labelText: 'Divisi',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: keteranganController,
                decoration: InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              TextField(
                autocorrect: false,
                controller: statusController,
                decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 35),
              ElevatedButton(
              onPressed: () async {
                final newModel = ProductRequestModel(
                 
                  namaProduk: nameController.text,
                  kodeProduk: codeController.text,
                  jumlahProduk: int.tryParse(qtyController.text)!,
                  sku: skuController.text,
                  sn: snController.text,
                  lisensi1: lisensiController.text,
                  lisensi2: lisensi2Controller.text,
                  divisi: divisiController.text,
                  keterangan: keteranganController.text,
                  tanggalOrder: orderController.text,
                  tanggalTerima: receiptController.text,
                  tanggalExpired: expiredController.text,
                  posisi: posisiController.text,
                  status: statusController.text,
                );
               

                try {
                  await ProductRemoteDatasource()
                      .updateProduk(produk.idProduk, newModel);
                  Navigator.pop(context);
                 
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Failed to edit task: $e'), 
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.read<ProductBloc>().add(
              //           EditProduct(
              //             name: nameController.text,
              //             productId: produk.idProduk.toString(),
              //             qty: int.tryParse(qtyController.text),
              //             code: codeController.text,
              //             sku: skuController.text,
              //             sn: snController.text,
              //             divisi: divisiController.text,
              //             keterangan: keteranganController.text,
              //             lisensi2: lisensi2Controller.text,
              //             lisensi: lisensiController.text,
              //             posisi: posisiController.text,
              //             status: statusController.text,
              //             expired: expiredController.text,
              //             order: orderController.text,
              //             receipt: receiptController.text,
              //           ),
              //         );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(vertical: 20),
              //     backgroundColor: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: BlocConsumer<ProductBloc, ProductState>(
              //     listener: (context, state) {
              //       if (state is StateError) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(state.message),
              //           ),
              //         );
              //       }
              //       if (state is StateSuccessEdit) {
              //         context.pop();
              //       }
              //     },
              //     builder: (context, state) {
              //       return Text(
              //         state is StateLoadingEdit
              //             ? "Loading..."
              //             : 'Update Product',
              //         style: const TextStyle(color: Colors.white),
              //       );
              //     },
              //   ),
              // ),
              // TextButton(
              //     onPressed: () {
              //       // context
              //       //     .read<ProductBloc>()
              //       //     .add(DeleteProduct(product.productId!));
              //     },
              //     child: BlocConsumer<ProductBloc, ProductState>(
              //       listener: (context, state) {
              //         if (state is StateError) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text(state.message),
              //             ),
              //           );
              //         }
              //         if (state is StateSuccessDelete) {
              //           context.pop();
              //         }
              //       },
              //       builder: (context, state) {
              //         return Text(
              //           state is StateLoadingDelete
              //               ? "Loading..."
              //               : 'Delete Product',
              //           style: const TextStyle(color: Colors.red),
              //         );
              //       },
              //     ))
            // ],
          // ));
      ),
    );
  }
}

