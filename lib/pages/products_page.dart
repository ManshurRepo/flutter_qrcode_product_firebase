import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc/product/product_bloc.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/product_model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productB = context.read<ProductBloc>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'All Products',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: StreamBuilder<QuerySnapshot<ProductModel>>(
          stream: productB.streamProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Tidak ada data"),
              );
            }

            List<ProductModel> allProducts = [];

            for (var element in snapshot.data!.docs) {
              allProducts.add(element.data());
            }

            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  ProductModel product = allProducts[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.goNamed(
                          Routes.updateProduct,
                          pathParameters: {
                            "productId": product.productId!,
                          },
                          extra: product,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 1.5)),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: QrImageView(
                                  data: product.code!,
                                  size: 200,
                                  version: QrVersions.auto,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Kode : ${product.code!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text("Nama : ${product.name!}"),
                            Text("Jumlah: ${product.qty}"),
                            Text("SN: ${product.sn}"),
                            Text("SKU: ${product.sku}"),
                            Text("divisi: ${product.divisi}"),
                            Text("keterangan: ${product.keterangan}"),
                            Text("lisensi: ${product.lisensi}"),
                            Text("lisensi2: ${product.lisensi2}"),
                            Text("posisi: ${product.posisi}"),
                            Text("status: ${product.status}"),
                            Text("tgl order: ${product.order}"),
                            Text("tgl receipt: ${product.receipt}"),
                            Text("tgl expired: ${product.expired}"),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
