
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/data/models/response/product_response_model.dart';
import 'package:flutter_scanqr/presentations/home/home_page.dart';
import 'package:flutter_scanqr/presentations/product/detail_product/bloc/produk_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../edit_product/product_update.dart';

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
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
               
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: BlocBuilder<ProdukBloc, ProdukState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox();
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              error: (message) {
                return Center(
                  child: Text(message),
                );
              },
              loaded: (model) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProdukBloc>().add(const ProdukEvent.getAll());
                  },
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: model.data.length,
                    itemBuilder: (context, index) {
                      Produk produk = model.data[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProductPage(
                                    produk.kodeProduk, produk),
                              ),
                            ).then((result) {
                              if (result == 'success') {
                                context
                                    .read<ProdukBloc>()
                                    .add(const ProdukEvent.getAll());
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                            ),
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
