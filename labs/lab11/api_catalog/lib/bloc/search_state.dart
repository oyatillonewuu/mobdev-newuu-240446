import 'package:api_catalog/models/product.dart';

sealed class SearchState {
  const SearchState();
}

class SearchIdle extends SearchState {
  const SearchIdle();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchEmpty extends SearchState {
  const SearchEmpty(this.query);
  final String query;
}

class SearchResults extends SearchState {
  const SearchResults(this.products);
  final List<Product> products;
}

class SearchError extends SearchState {
  const SearchError(this.message);
  final String message;
}
