import 'package:api_catalog/cubit/details_cubit.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/models/product.dart';
import 'package:api_catalog/screens/product_screen.dart';
import 'package:api_catalog/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatelessWidget {
  const Products(this.products, {super.key, required this.api});

  final ProductApi api;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, i) => ProductTile(
        product: products[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<DetailsCubit>(
              create: (context) => DetailsCubit(api)..load(products[i].id),
              child: ProductScreen(products[i]),
            ),
          ),
        ),
      ),
    );
  }
}
