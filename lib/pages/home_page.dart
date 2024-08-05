import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc/auth/auth_bloc.dart';
import 'package:flutter_scanqr/bloc/product/product_bloc.dart';
import 'package:flutter_scanqr/models/product_model.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'product_update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isMounted = true;

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLogout) {
                  return context.goNamed(Routes.login);
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogout());
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                );
              },
            )
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            late String title;
            late IconData icon;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = "Add Product";
                icon = Icons.post_add_rounded;
                onTap = () {
                  context.goNamed(Routes.addProduct);
                };
                break;
              case 1:
                title = "Products";
                icon = Icons.list_alt_outlined;
                onTap = () {
                  context.goNamed(Routes.products);
                };
                break;
              case 2:
                title = "QR Code";
                icon = Icons.qr_code;
                onTap = () async {
                  if (!_isMounted) return;

                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                    "#000000", "CANCEL", true, ScanMode.QR);

                  if (barcode.isNotEmpty) {
                    try {
                      var firestore = FirebaseFirestore.instance;
                      var snapshot = await firestore.collection("products").where("code", isEqualTo: barcode).get();
                      
                      if (!_isMounted) return;

                      if (snapshot.docs.isEmpty) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Produk dengan kode $barcode tidak ditemukan")),
                        );
                      } else {
                        var productData = snapshot.docs.first.data();
                        ProductModel product = ProductModel.fromJson(productData);

                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProductPage(product.productId!, product),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!_isMounted) return;

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  }
                };
                break;
              // case 3:
              //   title = "Download PDF";
              //   icon = Icons.picture_as_pdf;
              //   onTap = () {
              //     context.read<ProductBloc>().add(ExportProductEventToPdf());
              //   };
              //   break;
            }

            return Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (index == 3)
                        ? BlocConsumer<ProductBloc, ProductState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is StateLoadingExport) {
                                return const CircularProgressIndicator();
                              }
                              return SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  icon,
                                  size: 50,
                                ),
                              );
                            },
                          )
                        : Icon(
                            icon,
                            size: 50,
                          ),
                    const SizedBox(height: 8),
                    Text(title),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
