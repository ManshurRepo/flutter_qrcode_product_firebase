import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scanqr/data/datasources/auth_local_datasource.dart';
import 'package:flutter_scanqr/data/datasources/product_remote_datasource.dart';
import 'package:flutter_scanqr/data/models/response/auth_response_model.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/bloc/login_bloc.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_scanqr/presentations/auth/bloc/register/auth_bloc_bloc.dart';
import 'package:flutter_scanqr/presentations/product/add_product/bloc/add_produk_bloc.dart';
import 'package:flutter_scanqr/presentations/product/detail_product/bloc/produk_bloc.dart';

import 'presentations/auth/register_page.dart';
import 'presentations/home/home_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBlocBloc(),
        ),
         BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
       
        BlocProvider(
          create: (context) => ProdukBloc(),
        ),
        BlocProvider(
          create: (context) => AddProdukBloc(ProductRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<AuthResponseModel?>(
          future: AuthLocalDatasource().getAuthData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return RegisterPage();
            }
          },
        ), // Halaman utama aplikasi
      ),
    );
  }
}
