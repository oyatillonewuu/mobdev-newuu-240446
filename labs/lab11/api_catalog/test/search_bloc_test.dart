import 'package:api_catalog/bloc/search_bloc.dart';
import 'package:api_catalog/bloc/search_event.dart';
import 'package:api_catalog/bloc/search_state.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

import 'fake_client.dart';

void main() {
  final mockApi = ProductApi(
    client: getProductsFakeClient(),
    timeout: Duration(milliseconds: 200),
  );
  final testQuery = "phone";

  blocTest<SearchBloc, SearchState>(
    "success search emits [SearchLoading, SearchResults]",
    build: () => SearchBloc(mockApi),
    act: (bloc) => bloc.add(SearchSubmitted(testQuery)),
    wait: Duration.zero,
    expect: () => [isA<SearchLoading>(), isA<SearchResults>()],
  );

  blocTest<SearchBloc, SearchState>(
    "search with visibly empty query emits [SearchIdle]",
    build: () => SearchBloc(mockApi),
    act: (bloc) => bloc.add(SearchSubmitted("   ")),
    wait: Duration.zero,
    expect: () => [isA<SearchIdle>()],
  );
}
