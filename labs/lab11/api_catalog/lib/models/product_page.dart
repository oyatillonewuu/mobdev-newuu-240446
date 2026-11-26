import 'package:api_catalog/models/product.dart';

class ProductPage {
  const ProductPage({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  factory ProductPage.fromJson(Map<String, dynamic> json) => ProductPage(
    products: (json['products'] as List)
        .cast<Map<String, dynamic>>()
        .map((p) => Product.fromJson(p))
        .toList(),
    total: (json['total'] as num).toInt(),
    skip: (json['skip'] as num).toInt(),
    limit: (json['limit'] as num).toInt(),
  );
}
