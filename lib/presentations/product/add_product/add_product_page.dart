import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/data/models/request/product_request_model.dart';
import 'package:flutter_scanqr/presentations/product/add_product/add_product_success_page.dart';
import 'package:flutter_scanqr/presentations/product/add_product/bloc/add_produk_bloc.dart';

import '../../home/home_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController snController = TextEditingController();
  final TextEditingController lisensi1Controller = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              maxLength: 10,
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Product Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Product Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              maxLength: 10,
              controller: skuController,
              decoration: InputDecoration(
                labelText: 'SKU',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              maxLength: 25,
              controller: snController,
              decoration: InputDecoration(
                labelText: 'SN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              maxLength: 20,
              controller: lisensi1Controller,
              decoration: InputDecoration(
                labelText: 'Lisensi 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              maxLength: 20,
              controller: lisensi2Controller,
              decoration: InputDecoration(
                labelText: 'Lisensi 2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: orderController,
              decoration: InputDecoration(
                labelText: 'Tanggal Order',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: receiptController,
              decoration: InputDecoration(
                labelText: 'Tanggal Receipt',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: expiredController,
              decoration: InputDecoration(
                labelText: 'Tanggal Expired',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: posisiController,
              decoration: InputDecoration(
                labelText: 'Posisi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: divisiController,
              decoration: InputDecoration(
                labelText: 'Divisi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: keteranganController,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              controller: statusController,
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final model = ProductRequestModel(
                  namaProduk: nameController.text,
                  kodeProduk: codeController.text,
                  jumlahProduk: int.tryParse(qtyController.text) ?? 0,
                  sku: skuController.text,
                  sn: snController.text,
                  lisensi1: lisensi1Controller.text,
                  lisensi2: lisensi2Controller.text,
                  divisi: divisiController.text,
                  keterangan: keteranganController.text,
                  tanggalOrder: orderController.text,
                  tanggalTerima: receiptController.text,
                  tanggalExpired: expiredController.text,
                  posisi: posisiController.text,
                  status: statusController.text,
                );
                context
                    .read<AddProdukBloc>()
                    .add(AddProdukEvent.addProduk(model));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: BlocConsumer<AddProdukBloc, AddProdukState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loaded: (state) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddProductSuccessPage()),
                      );
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add Produk Error: $message'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  if (state == const AddProdukState.loading()) {
                    return const Center(
                      child: SizedBox(
                        width: 22, // Atur lebar sesuai dengan keinginan Anda
                        height: 22, // Atur tinggi sesuai dengan keinginan Anda
                        child: CircularProgressIndicator(
                          strokeWidth:
                              3, // Atur lebar garis progress sesuai keinginan Anda
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return const Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
