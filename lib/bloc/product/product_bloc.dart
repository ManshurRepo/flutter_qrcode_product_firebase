import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scanqr/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfw;
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* firestore
        .collection("products")
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .snapshots();
  }

  ProductBloc() : super(StateInitial()) {
    on<AddProduct>((event, emit) async {
      try {
        emit(StateLoadingAdd());
        // add product to firebase
        var hasil = await firestore
            .collection("products")
            .add({"name": event.name, "code": event.code, "qty": event.qty});

        await firestore
            .collection("products")
            .doc(hasil.id)
            .update({"productId": hasil.id});
        emit(StateSuccessAdd());
      } on FirebaseException catch (e) {
        emit(StateError(e.message ?? "Tidak dapat menambah produk"));
      } catch (e) {
        emit(StateError("Tidak dapat menambah produk"));
      }
    });
    on<EditProduct>((event, emit) async {
      try {
        emit(StateLoadingEdit());

        await firestore.collection("products").doc(event.productId).update({
          "name": event.name,
          "qty": event.qty,
        });

        emit(StateSuccessEdit());
      } on FirebaseException catch (e) {
        emit(StateError(e.message ?? "Tidak dapat mengupdate produk"));
      } catch (e) {
        emit(StateError("Tidak dapat mengupdate produk"));
      }
    });
    on<DeleteProduct>((event, emit) async {
      try {
        emit(StateLoadingDelete());
        // add product to firebase
        await firestore.collection("products").doc(event.id).delete();
        emit(StateSuccessDelete());
      } on FirebaseException catch (e) {
        emit(StateError(e.message ?? "Tidak dapat menghapus produk"));
      } catch (e) {
        emit(StateError("Tidak dapat menghaous produk"));
      }
    });

    on<ExportProductEventToPdf>((event, emit) async {
      try {
        emit(StateLoadingExport());

        // 1. ambil data product dari firebase
        var querySnap = await firestore
            .collection("products")
            .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson(),
            )
            .get();

        List<Product> allProducts = [];

        // reset all products untuk mengatasi duplikat
        // allProducts;
        // all products sudah ada isinya *tergantung isi didatabasenya.
        for (var element in querySnap.docs) {
          Product product = element.data();
          allProducts.add(product);
        }

        // 2. buat pdf  -> disimpan di lokal -> diarahkan dengan path

        //font style
        // var data = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");

        // var myFont = Font.ttf(data);

        // var myStyle = TextStyle(font: myFont);

        final pdf = pdfw.Document();
        pdf.addPage(
          pdfw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              List<pdfw.TableRow> allData = List.generate(
                allProducts.length,
                (index) {
                  Product product = allProducts[index];
                  return pdfw.TableRow(
                    children: [
                      // No
                      pdfw.Padding(
                        padding: const pdfw.EdgeInsets.all(20),
                        child: pdfw.Text("No ${index + 1}",
                            style: const pdfw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pdfw.TextAlign.center),
                      ),
                      // Kode Barang
                      pdfw.Padding(
                        padding: pdfw.EdgeInsets.all(20),
                        child: pdfw.Text(product.code!,
                            style: const pdfw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pdfw.TextAlign.center),
                      ),
                      // Nama Barang
                      pdfw.Padding(
                        padding: const pdfw.EdgeInsets.all(20),
                        child: pdfw.Text(product.name!,
                            style: const pdfw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pdfw.TextAlign.center),
                      ),
                      // Qty
                      pdfw.Padding(
                        padding: const pdfw.EdgeInsets.all(20),
                        child: pdfw.Text("${product.qty}",
                            style: const pdfw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pdfw.TextAlign.center),
                      ),
                      // QR Code
                      pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: pdfw.Barcode.qrCode(),
                            data: product.code!,
                            height: 50,
                            width: 50,
                          )),
                    ],
                  );
                },
              );
              return [
                pdfw.Center(
                  child: pdfw.Text("Catalog Products",
                      style: const pdfw.TextStyle(fontSize: 24),
                      textAlign: pdfw.TextAlign.center),
                ),
                pdfw.SizedBox(height: 20),
                pdfw.Table(
                  border: pdfw.TableBorder.all(
                      color: PdfColor.fromHex("#000000"), width: 2),
                  children: [
                    pdfw.TableRow(
                      children: [
                        // No
                        pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.Text("No",
                              style: pdfw.TextStyle(
                                fontSize: 10,
                                fontWeight: pdfw.FontWeight.bold,
                              ),
                              textAlign: pdfw.TextAlign.center),
                        ),

                        // Kode Barang
                        pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.Text("Product Code",
                              style: pdfw.TextStyle(
                                fontSize: 10,
                                fontWeight: pdfw.FontWeight.bold,
                              ),
                              textAlign: pdfw.TextAlign.center),
                        ),
                        // Nama Barang
                        pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.Text("Product Name",
                              style: pdfw.TextStyle(
                                fontSize: 10,
                                fontWeight: pdfw.FontWeight.bold,
                              ),
                              textAlign: pdfw.TextAlign.center),
                        ),
                        // Qty
                        pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.Text("Quantity",
                              style: pdfw.TextStyle(
                                fontSize: 10,
                                fontWeight: pdfw.FontWeight.bold,
                              ),
                              textAlign: pdfw.TextAlign.center),
                        ),
                        // QR Code
                        pdfw.Padding(
                          padding: const pdfw.EdgeInsets.all(20),
                          child: pdfw.Text("QR Code",
                              style: pdfw.TextStyle(
                                fontSize: 10,
                                fontWeight: pdfw.FontWeight.bold,
                              ),
                              textAlign: pdfw.TextAlign.center),
                        ),
                      ],
                    ),
                    // Isi Data
                    ...allData
                  ],
                ),
              ];
            },
          ),
        );

        // 3. open pdf

        Uint8List bytes = await pdf.save();
        final dir = await getApplicationCacheDirectory();
        File file = File("${dir.path}/myproducts.pdf");

        // masukan data variabel bytes ke file pdf
        await file.writeAsBytes(bytes);

        await OpenFile.open(file.path);

        print(file.path);

        emit(StateSuccessExport());
      } on FirebaseException catch (e) {
        emit(StateError(e.message ?? "Tidak dapat membuat file pdf produk"));
      } catch (e) {
        emit(StateError("Tidak dapat membuat file pdf produk"));
      }
    });
  }
}
