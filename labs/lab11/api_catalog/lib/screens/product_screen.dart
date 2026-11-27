import 'package:api_catalog/cubit/details_cubit.dart';
import 'package:api_catalog/models/product.dart';
import 'package:api_catalog/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product #${product.id}")),
      body: BlocBuilder<DetailsCubit, ProductState>(
        builder: (context, state) => switch (state) {
          ProductLoading() => const Center(child: CircularProgressIndicator()),
          ProductError(:final message) => Center(child: Text(message)),
          ProductLoaded(:final product) => ProductCard(product),
        },
      ),
    );
  }
}
