import 'package:flutter_scanqr/models/product_model.dart';
import 'package:flutter_scanqr/pages/product_update.dart';
import 'package:flutter_scanqr/pages/products_page.dart';
import 'package:go_router/go_router.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../pages/add_product_page.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

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
                state.extra as ProductModel
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
