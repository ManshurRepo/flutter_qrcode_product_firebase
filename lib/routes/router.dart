import 'package:flutter_scanqr/data/models/response/product_model.dart';
import 'package:flutter_scanqr/data/models/response/product_response_model.dart';
import 'package:flutter_scanqr/presentations/product/edit_product/product_update.dart';
import 'package:flutter_scanqr/presentations/product/detail_product/products_page.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../presentations/product/add_product/add_product_page.dart';
import '../presentations/error/error_page.dart';
import '../presentations/home/home_page.dart';
import '../presentations/auth/login_page.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return "/login_page";
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'products_page',
          name: Routes.products,
          builder: (context, state) => const ProductsPage(),
          routes: [
            GoRoute(
              path: ':productId',
              name: Routes.updateProduct,
              builder: (context, state) => UpdateProductPage(
                state.pathParameters['productId'].toString(),
                state.extra as Produk
              ),
            )
          ],
        ),
        GoRoute(
          path: 'add_product',
          name: Routes.addProduct,
          builder: (context, state) =>  AddProductPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/login_page',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
