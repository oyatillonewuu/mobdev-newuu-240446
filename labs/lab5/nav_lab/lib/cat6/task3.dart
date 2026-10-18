import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const ProductListScreen()),
    GoRoute(
      path: '/product-details',
      builder: (context, state) =>
          ProductScreen(product: state.extra! as Product),
    ),
  ],
);

class Product {
  final String name;
  final double price;

  const Product({required this.name, required this.price});
}

const products = [
  Product(name: "Thinkpad l13 gen3", price: 800.0),
  Product(name: "Macbook Pro M1 Max", price: 1000.0),
  Product(name: "Thinkpad X1 Carbon 13'", price: 1300.0),
  Product(name: "Framework 13'", price: 1500.0),
];

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView(
        children: [
          for (final product in products)
            ListTile(
              title: Text(product.name),
              onTap: () => context.push('/product-details', extra: product),
            ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product detail")),
      body: Center(
        child: Column(
          spacing: 5.0,
          children: [
            Text("Name: ${product.name}"),
            Text("Price: \$${product.price}"),
          ],
        ),
      ),
    );
  }
}

// Answer to the question (based on google search AI overview):
//  In this approach, if this app were used in a browser,
//  a refresh causes loss of data (the parameter [extra]) since
//  it causes clena up of data stored in the RAM.
//
//  In contrast, encoding in URL as path param ensures state
//  persistence (using an identifier or straightly encoding
//  the data).
