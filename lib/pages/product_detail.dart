import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc/product/product_bloc.dart';
import 'package:flutter_scanqr/models/product_model.dart';
import 'package:flutter_scanqr/routes/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage(this.id, this.product, {super.key});

  final String id;

  final Product product;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeController.text = product.code!;
    nameController.text = product.name!;
    qtyController.text = product.qty!.toString();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Detail Product', style: TextStyle(color: Colors.white),),
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
                      data: product.code!,
                      size: 200,
                      version: QrVersions.auto,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: codeController,
                keyboardType: TextInputType.number,
                readOnly: true,
                maxLength: 10,
                decoration: InputDecoration(
                    label: const Text("Kode Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: const Text("Nama Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: const Text("Jumlah Produk"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductBloc>().add(
                        EditProduct(
                          name: nameController.text,
                          productId: product.productId!,
                          qty: int.tryParse(qtyController.text) ?? 0,
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is StateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is StateSuccessEdit) {
                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      state is StateLoadingEdit ? "Loading..." : 'Update Product',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<ProductBloc>()
                        .add(DeleteProduct(product.productId!));
                  },
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is StateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                      if (state is StateSuccessDelete) {
                        context.pop();
                      }
                    },
                    builder: (context, state) {
                      return Text(
                        state is StateLoadingDelete
                            ? "Loading..."
                            : 'Delete Product',
                        style: const TextStyle(color: Colors.red),
                      );
                    },
                  ))
            ],
          )),
    );
  }
}
