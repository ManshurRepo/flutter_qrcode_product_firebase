import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc_firebase/product/product_bloc.dart';
import 'package:flutter_scanqr/data/models/response/product_response_model.dart';
import 'package:flutter_scanqr/presentations/product/detail_product/bloc/produk_bloc.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProdukBloc>().add(const ProdukEvent.getAll());
  }

  @override
  Widget build(BuildContext context) {
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
        // body: StreamBuilder<QuerySnapshot<ProductModel>>(
        //   stream: productB.streamProducts(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Center(
        //         child: Text("Error: ${snapshot.error}"),
        //       );
        //     }
        //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //       return const Center(
        //         child: Text("Tidak ada data"),
        //       );
        //     }

        //     List<ProductModel> allProducts = [];

        //     for (var element in snapshot.data!.docs) {
        //       allProducts.add(element.data());
        //     }
        body: BlocBuilder<ProdukBloc, ProdukState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const SizedBox();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, error: (message) {
              return Center(
                child: Text(message),
              );
            }, loaded: (model){
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemCount: model.data.length,
                itemBuilder: (context, index) {
                  Produk produk = model.data[index];
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
                            "productId": produk.kodeProduk,
                          },
                          extra: produk,
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
                                  data: produk.kodeProduk,
                                  size: 200,
                                  version: QrVersions.auto,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Kode : ${produk.kodeProduk}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text("Nama : ${produk.namaProduk}"),
                            Text("Jumlah: ${produk.jumlahProduk}"),
                            Text("SN: ${produk.sn}"),
                            Text("SKU: ${produk.sku}"),
                            Text("DIVISI: ${produk.divisi}"),
                            Text("keterangan: ${produk.keterangan}"),
                            Text("lisensi: ${produk.lisensi1}"),
                            Text("lisensi2: ${produk.lisensi2}"),
                            Text("posisi: ${produk.posisi}"),
                            Text("status: ${produk.status}"),
                            Text("tgl order: ${produk.tanggalOrder}"),
                            Text("tgl receipt: ${produk.tanggalTerima}"),
                            Text("tgl expired: ${produk.tanggalExpired}"),
                          ],
                        ),
                      ),
                    ),
                      );
                   
                });
            });

          },
        ),
      ),
    );
  }
}