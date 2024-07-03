import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/bloc_firebase/auth/auth_bloc.dart';
import 'package:flutter_scanqr/bloc_firebase/product/product_bloc.dart';
import 'package:flutter_scanqr/data/datasources/product_remote_datasource.dart';
import 'package:flutter_scanqr/firebase_options.dart';
import 'package:flutter_scanqr/presentations/auth/login_page.dart';
import 'package:flutter_scanqr/presentations/product/add_product/bloc/add_produk_bloc.dart';
import 'package:flutter_scanqr/presentations/product/detail_product/bloc/produk_bloc.dart';

import 'presentations/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => ProdukBloc(),
        ),
        BlocProvider(
          create: (context) => AddProdukBloc(ProductRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(), // Halaman utama aplikasi
    
      ),
    );
  }
}
