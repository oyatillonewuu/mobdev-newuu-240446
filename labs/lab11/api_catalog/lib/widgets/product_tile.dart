import 'package:api_catalog/models/product.dart';
import 'package:flutter/material.dart';

const double imageWidth = 100;

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, required this.onTap});

  final void Function() onTap;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.thumbnail,
        width: imageWidth,
        errorBuilder: (_, _, _) {
          return const SizedBox(
            width: imageWidth,
            child: Icon(Icons.image_not_supported, color: Colors.grey),
          );
        },
      ),
      title: Text(product.title),
      subtitle: Text(
        "\$${product.price.toStringAsFixed(2)} • ★ ${product.rating.toStringAsFixed(1)}",
      ),
      onTap: onTap,
    );
  }
}
