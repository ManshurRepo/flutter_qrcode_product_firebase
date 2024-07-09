import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/data/models/request/edit_product_request_model.dart';
import 'package:flutter_scanqr/data/models/response/product_response_model.dart';
import 'package:flutter_scanqr/presentations/product/add_product/bloc/add_produk_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage(this.id, this.produk, {Key? key}) : super(key: key);

  final String id;
  final Produk produk;

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController codeController = TextEditingController();
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
  void initState() {
    super.initState();
    codeController.text = widget.produk.kodeProduk;
    nameController.text = widget.produk.namaProduk;
    qtyController.text = widget.produk.jumlahProduk.toString();
    skuController.text = widget.produk.sku;
    snController.text = widget.produk.sn;
    lisensiController.text = widget.produk.lisensi1;
    lisensi2Controller.text = widget.produk.lisensi2;
    orderController.text = widget.produk.tanggalOrder;
    receiptController.text = widget.produk.tanggalExpired;
    expiredController.text = widget.produk.tanggalTerima;
    posisiController.text = widget.produk.posisi;
    statusController.text = widget.produk.status;
    keteranganController.text = widget.produk.keterangan;
    divisiController.text = widget.produk.divisi;
  }

  @override
  Widget build(BuildContext context) {
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
                    data: widget.produk.kodeProduk,
                    size: 200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Kode Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah Produk",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: skuController,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: 'SKU',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: snController,
              maxLength: 25,
              decoration: const InputDecoration(
                labelText: 'SN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lisensiController,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Lisensi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lisensi2Controller,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Lisensi 2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: orderController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Order',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: receiptController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Receipt',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: expiredController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Expired',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: posisiController,
              decoration: const InputDecoration(
                labelText: 'Posisi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: divisiController,
              decoration: const InputDecoration(
                labelText: 'Divisi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: keteranganController,
              decoration: const InputDecoration(
                labelText: 'Keterangan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            BlocListener<AddProdukBloc, AddProdukState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (_) {
                    Navigator.pop(
                        context, 'success'); // Pop dengan hasil 'success'
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update product: $message'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              child: BlocBuilder<AddProdukBloc, AddProdukState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => ElevatedButton(
                      onPressed: () {
                        final model = EditProductRequestModel(
                          idProduk: widget.produk.idProduk,
                          namaProduk: nameController.text,
                          kodeProduk: codeController.text,
                          jumlahProduk: int.tryParse(qtyController.text) ?? 0,
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
                        context.read<AddProdukBloc>().add(
                            AddProdukEvent.editProduk(model.idProduk, model));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final productId = widget.produk.idProduk;
                context
                    .read<AddProdukBloc>()
                    .add(AddProdukEvent.deleteProduk(productId));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: BlocConsumer<AddProdukBloc, AddProdukState>(
                listener: (context, state) {
                  state.maybeWhen(
                    deleteLoading: () {
                      // Tidak perlu melakukan apa pun di sini karena kita menangani tampilan di builder.
                    },
                    deleteLoaded: (_) {
                      Navigator.pop(context, 'success');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product deleted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to delete product: $message'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  if (state == const AddProdukState.deleteLoading()) {
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
                      "Delete",
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
