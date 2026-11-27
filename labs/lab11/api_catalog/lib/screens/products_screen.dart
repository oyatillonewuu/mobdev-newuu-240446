import 'package:api_catalog/apps.dart';
import 'package:api_catalog/cubit/products_cubit.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/widgets/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchApp()),
              );
            },
            child: Text("Search"),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) => switch (state) {
          ProductsLoading() => const Center(child: CircularProgressIndicator()),
          ProductsError(:final message) => Center(child: Text(message)),
          ProductsLoaded(:final products) => Column(
            spacing: 10,
            children: [
              Expanded(
                child: Products(products, api: context.read<ProductApi>()),
              ),
              if (state is ProductsLoadingMore) CircularProgressIndicator(),
              if (state.hasMore)
                ElevatedButton(
                  onPressed: (state is ProductsLoadingMore)
                      ? null
                      : () async {
                          await context.read<ProductsCubit>().loadMore();
                        },
                  child: Text(
                    "Load more (${products.length} of ${state.total})",
                  ),
                ),
              SizedBox(height: 5),
            ],
          ),
        },
      ),
    );
  }
}
