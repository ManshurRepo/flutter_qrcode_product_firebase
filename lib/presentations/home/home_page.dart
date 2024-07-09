// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_scanqr/bloc_firebase/auth/auth_bloc.dart';
// import 'package:flutter_scanqr/bloc_firebase/product/product_bloc.dart';
// import 'package:flutter_scanqr/data/datasources/product_remote_datasource.dart';
// import 'package:flutter_scanqr/presentations/auth/login_page.dart';

// import '../../data/models/response/product_response_model.dart';
// import '../product/add_product/add_product_page.dart';
// import '../product/detail_product/products_page.dart';
// import '../product/edit_product/product_update.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   bool _isMounted = true;

//   @override
//   void dispose() {
//     _isMounted = false;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: const Text(
//             'Home Page',
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           actions: [
//             BlocConsumer<AuthBloc, AuthState>(
//               listener: (context, state) {
//                 if (state is AuthStateLogout) {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => LoginPage()));
//                 }
//               },
//               builder: (context, state) {
//                 return IconButton(
//                   onPressed: () {
//                     context.read<AuthBloc>().add(AuthEventLogout());
//                   },
//                   icon: const Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//         body: GridView.builder(
//           padding: const EdgeInsets.all(20),
//           itemCount: 4,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 20,
//             crossAxisSpacing: 20,
//           ),
//           itemBuilder: (context, index) {
//             late String title;
//             late IconData icon;
//             late VoidCallback onTap;

//             switch (index) {
//   case 0:
//     title = "Add Product";
//     icon = Icons.post_add_rounded;
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AddProductPage()),
//       );
//     };
//     break;
//               case 1:
//                 title = "Products";
//                 icon = Icons.list_alt_outlined;
//                 onTap = () {
//                  Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ProductsPage()),
//                   );
//                 };
//                 break;
//               case 2:
//                 title = "QR Code";
//                 icon = Icons.qr_code;
//                 onTap = () async {
//                   if (!_isMounted) return;

//                   String barcode = await FlutterBarcodeScanner.scanBarcode(
//                       "#000000", "CANCEL", true, ScanMode.QR);

//                   if (barcode != "-1") {
//                     // Cek apakah barcode bukan nilai default saat dibatalkan
//                     try {
//                       var productRemoteDatasource = ProductRemoteDatasource();
//                       var result = await productRemoteDatasource.getProducts();

//                       if (!_isMounted) return;

//                       result.fold(
//                         (error) {
//                           if (!_isMounted) return;
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Error: $error")),
//                           );
//                         },
//                         (productResponse) {
//                           var products = productResponse.data;
//                           var matchedProduct = products.firstWhere(
//                             (product) => product.kodeProduk == barcode,
//                             orElse: () => Produk(
//                               idProduk: -1, // Nilai dummy
//                               namaProduk: "",
//                               kodeProduk: "",
//                               jumlahProduk: 0,
//                               sku: "",
//                               sn: "",
//                               lisensi1: "",
//                               lisensi2: "",
//                               divisi: "",
//                               keterangan: "",
//                               tanggalOrder: "",
//                               tanggalTerima: "",
//                               tanggalExpired: "",
//                               posisi: "",
//                               status: "",
//                             ),
//                           );

//                           if (matchedProduct.idProduk == -1) {
//                             // Memeriksa apakah produk ditemukan atau tidak
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text(
//                                       "Produk dengan kode $barcode ini tidak ditemukan")),
//                             );
//                           } else {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => UpdateProductPage(
//                                     matchedProduct.idProduk.toString(),
//                                     matchedProduct),
//                               ),
//                             );
//                           }
//                         },
//                       );
//                     } catch (e) {
//                       if (!_isMounted) return;
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Error: $e")),
//                       );
//                     }
//                   }
//                 };
//                 break;
//               case 3:
//                 title = "Download PDF";
//                 icon = Icons.picture_as_pdf;
//                 onTap = () {
//                   context.read<ProductBloc>().add(ExportProductEventToPdf());
//                 };
//                 break;
//             }

//             return Material(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(20),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(20),
//                 onTap: onTap,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     (index == 3)
//                         ? BlocConsumer<ProductBloc, ProductState>(
//                             listener: (context, state) {},
//                             builder: (context, state) {
//                               if (state is StateLoadingExport) {
//                                 return const CircularProgressIndicator();
//                               }
//                               return SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: Icon(
//                                   icon,
//                                   size: 50,
//                                 ),
//                               );
//                             },
//                           )
//                         : Icon(
//                             icon,
//                             size: 50,
//                           ),
//                     const SizedBox(height: 8),
//                     Text(title),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_scanqr/data/datasources/auth_local_datasource.dart';
import 'package:flutter_scanqr/data/datasources/product_remote_datasource.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/register/auth_bloc_bloc.dart';
import 'package:flutter_scanqr/presentations/auth/login_page.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/response/product_response_model.dart';
import '../product/add_product/add_product_page.dart';
import '../product/detail_product/products_page.dart';
import '../product/edit_product/product_update.dart';

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                },
                icon: const Icon(Icons.logout),
                color: Colors.white,
              ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductPage()),
                  );
                };
                break;
              case 1:
                title = "Products";
                icon = Icons.list_alt_outlined;
                onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsPage()),
                  );
                };
                break;
              case 2:
                title = "QR Code";
                icon = Icons.qr_code;
                onTap = () async {
                  if (!_isMounted) return;

                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                      "#000000", "CANCEL", true, ScanMode.QR);

                  if (barcode != "-1") {
                    try {
                      var productRemoteDatasource = ProductRemoteDatasource();
                      var result = await productRemoteDatasource.getProducts();

                      if (!_isMounted) return;

                      result.fold(
                        (error) {
                          if (!_isMounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $error")),
                          );
                        },
                        (productResponse) {
                          var products = productResponse.data;
                          var matchedProduct = products.firstWhere(
                            (product) => product.kodeProduk == barcode,
                            orElse: () => Produk(
                              idProduk: -1,
                              namaProduk: "",
                              kodeProduk: "",
                              jumlahProduk: 0,
                              sku: "",
                              sn: "",
                              lisensi1: "",
                              lisensi2: "",
                              divisi: "",
                              keterangan: "",
                              tanggalOrder: "",
                              tanggalTerima: "",
                              tanggalExpired: "",
                              posisi: "",
                              status: "",
                            ),
                          );

                          if (matchedProduct.idProduk == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Produk dengan kode $barcode tidak ditemukan"),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProductPage(
                                  matchedProduct.idProduk.toString(),
                                  matchedProduct,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    } catch (e) {
                      if (!_isMounted) return;
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
                // onTap = () {
                //   context.read<ProductBloc>().add(ExportProductEventToPdf());
              //   };
              //   break;
              // default:
              //   break;
            }

            return Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Icon(
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
