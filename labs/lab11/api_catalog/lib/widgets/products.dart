import 'package:api_catalog/models/product.dart';
import 'package:api_catalog/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  const Products(this.products, {super.key, required this.onTap});

  final List<Product> products;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, i) =>
          ProductTile(product: products[i], onTap: () => onTap(i)),
    );
  }
}
