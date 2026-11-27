import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/models/product.dart';
import 'package:bloc/bloc.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsError extends ProductsState {
  const ProductsError(this.message);
  final String message;
}

final class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products, {required this.total});
  final List<Product> products;
  final int total;
  bool get hasMore => products.length < total;
}

final class ProductsLoadingMore extends ProductsLoaded {
  const ProductsLoadingMore(super.products, {required super.total});
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._api) : super(const ProductsLoading());
  final ProductApi _api;
  Future<void> load() async {
    emit(const ProductsLoading());
    try {
      final page = await _api.getProducts();
      // if (isClosed) return;
      emit(ProductsLoaded(page.products, total: page.total));
    } on ApiException catch (e) {
      if (!isClosed) emit(ProductsError(e.message));
    }
  }

  Future<void> loadMore() async {
    if (state is ProductsLoading) return;
    if (state is ProductsLoaded) {
      final stateCasted = state as ProductsLoaded;
      if (!stateCasted.hasMore) return;
      emit(ProductsLoadingMore(stateCasted.products, total: stateCasted.total));
      final skip = stateCasted.products.length;
      final page = await _api.getProducts(skip: skip);
      emit(
        ProductsLoaded(stateCasted.products + page.products, total: page.total),
      );
    }
  }
}
