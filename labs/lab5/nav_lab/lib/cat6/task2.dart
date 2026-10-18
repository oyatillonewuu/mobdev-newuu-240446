import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const products = "/";
  static const product = "/products/:id";

  static String getProductPathWithId(int id) {
    return "/products/$id";
  }
}

final router = GoRouter(
  initialLocation: AppRoutes.products,
  routes: [
    GoRoute(
      path: AppRoutes.products,
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: AppRoutes.product,
      builder: (context, state) {
        return ProductScreen(productId: state.pathParameters["id"]!);
      },
    ),
  ],
);

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView(
        children: [
          for (final i in Iterable.generate(3))
            ListTile(
              title: Text("Product #${i + 1}"),
              onTap: () => context.push(AppRoutes.getProductPathWithId(i + 1)),
            ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product detail")),
      body: Center(child: Text("Product #$productId")),
    );
  }
}
