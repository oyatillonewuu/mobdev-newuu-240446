import 'package:api_catalog/bloc/search_state.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/widgets/products.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search(
    this.state, {
    required this.api,
    required this.onSubmit,
    super.key,
  });

  final ProductApi api;
  final SearchState state;
  final void Function(String query) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20.0,
        children: [
          Center(child: SearchBox(onSubmit)),
          switch (state) {
            SearchIdle() => Text(
              "Type to search for products...",
              style: TextTheme.of(context).titleMedium,
            ),
            SearchLoading() => const CircularProgressIndicator(),
            SearchResults(:final products) => Expanded(
              child: Products(products, api: api),
            ),
            SearchEmpty(:final query) => Text(
              "No results found for '$query'.",
              style: TextTheme.of(context).titleMedium,
            ),
            SearchError(:final message) => Text(message),
          },
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  SearchBox(this.onSubmit, {super.key});

  final void Function(String query) onSubmit;
  final TextEditingController _controller = TextEditingController();

  void _onSubmit() {
    final String query = _controller.text;
    onSubmit(query);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisSize: .min,
          spacing: 10.0,
          children: [
            TextField(controller: _controller, onEditingComplete: _onSubmit),
            ElevatedButton(onPressed: _onSubmit, child: const Text("Search")),
          ],
        ),
      ),
    );
  }
}
