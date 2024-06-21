import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc/auth/auth_bloc.dart';
import 'package:flutter_scanqr/bloc/product/product_bloc.dart';
import 'package:flutter_scanqr/models/product_model.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
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
                  return context.goNamed(Routes.home);
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
          itemCount: 4,
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
                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                      "#000000", "CANCEL", true, ScanMode.QR);
                  //get data dari firebase search by product id
                  // Future<Map<String, dynamic>> getProductById(String id) async {
                  //   try {
                  //     var hasil = await firestore.collection("products").doc(id).get();

                  //     if(hasil.data() == null) {

                  //         return {
                  //       "error": true,
                  //       "message":
                  //           "Tidak ada product id didatabse"
                  //     };
                  //     }
                  //     return {
                  //       "error": false,
                  //       "message":
                  //           "Berhasil mendapatkan detail product dari product code ini",
                  //           "data" : Product.fromJson(hasil.data()!),
                  //     };
                  //   } catch (e) {
                  //     return {
                  //       "error": true,
                  //       "message":
                  //           "Tidak mendapatkan detail product dari product code ini"
                  //     };
                  //   }
                  // }
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Hasil scan: $barcode"),
                      duration: Duration(seconds: 2), // Durasi snackbar 2 detik
                    ),
                  );

                  // ignore: use_build_context_synchronously
                  context.goNamed(Routes.detailProduct);
                };
                break;
              case 3:
                title = "Catalog";
                icon = Icons.document_scanner_rounded;
                onTap = () {
                  context.read<ProductBloc>().add(ExportProductEventToPdf());
                };
                break;
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
                                return CircularProgressIndicator();
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
