import 'package:api_catalog/bloc/search_bloc.dart';
import 'package:api_catalog/cubit/products_cubit.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/screens/products_screen.dart';
import 'package:api_catalog/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ProductApi(),
      child: BlocProvider(
        create: (context) => ProductsCubit(context.read<ProductApi>())..load(),
        child: const ProductsScreen(),
      ),
    );
  }
}

class SearchApp extends StatelessWidget {
  const SearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      // TODO: give its own instance of API
      create: (_) => ProductApi(),
      child: BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(context.read<ProductApi>()),
        child: const SearchScreen(),
      ),
    );
  }
}
