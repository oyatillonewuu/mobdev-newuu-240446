import 'package:api_catalog/bloc/search_bloc.dart';
import 'package:api_catalog/bloc/search_event.dart';
import 'package:api_catalog/bloc/search_state.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search products")),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => Search(
          state,
          api: context.read<ProductApi>(),
          onSubmit: (String query) {
            context.read<SearchBloc>().add(SearchSubmitted(query));
          },
        ),
      ),
    );
  }
}
