import 'package:api_catalog/bloc/search_event.dart';
import 'package:api_catalog/bloc/search_state.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._api) : super(const SearchIdle()) {
    on<SearchSubmitted>(_onSubmitted, transformer: restartable());
    on<SearchCleared>((event, emit) => emit(const SearchIdle()));
  }
  final ProductApi _api;
  Future<void> _onSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(const SearchIdle());
      return;
    }
    emit(const SearchLoading());
    try {
      final page = await _api.search(query);
      emit(
        page.products.isEmpty
            ? SearchEmpty(query)
            : SearchResults(page.products),
      );
    } on ApiException catch (e) {
      emit(SearchError(e.message));
    }
  }
}
