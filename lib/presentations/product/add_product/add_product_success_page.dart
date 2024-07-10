import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../detail_product/products_page.dart';

class AddProductSuccessPage extends StatefulWidget {
  const AddProductSuccessPage({super.key});

  @override
  State<AddProductSuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<AddProductSuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Alert(
        context: context,
        style: const AlertStyle(
          backgroundColor: Colors.white,
          animationType: AnimationType.grow,
          animationDuration: Duration(seconds: 1),
        ),
        type: AlertType.success,
        desc: "Produk Berhasil Ditambahkan",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ProductsPage();
            })),
            width: 120,
            color: Colors.blue,
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
