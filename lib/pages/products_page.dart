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
          title: const Text('All Products'),
          backgroundColor: Colors.blue,
        ),
        body: StreamBuilder<QuerySnapshot<Product>>(
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

            List<Product> allProducts = [];

            for (var element in snapshot.data!.docs) {
              allProducts.add(element.data());
            }

            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  Product product = allProducts[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        context.goNamed(Routes.detailProduct,
                        pathParameters: {
                          "productId" : product.productId!,
                        },
                       
                        extra: product,
                        );
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.code!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(product.name!),
                                  Text("Jumlah: ${product.qty}"),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: QrImageView(
                                  data: product.code!,
                                  size: 200,
                                  version: QrVersions.auto,
                                ),)
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
