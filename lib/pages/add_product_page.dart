import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc/product/product_bloc.dart';
import 'package:flutter_scanqr/routes/router.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              maxLength: 10,
              controller: codeController,
              decoration: InputDecoration(
                  labelText: 'Product Code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Product Quantity',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (codeController.text.length == 10) {
                    context.read<ProductBloc>().add(
                          AddProduct(
                              code: codeController.text,
                              name: nameController.text,
                              qty: int.tryParse(qtyController.text) ?? 0),
                        );
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Kode produk harus 10 karakter")));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is StateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is StateSuccessAdd) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Produk berhasil ditambahkan"),
                        ),
                      );

                      context.pop();
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      state is StateLoadingAdd ? "Loading..." : 'Add Product',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
