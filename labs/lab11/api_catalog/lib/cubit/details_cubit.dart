import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ProductState {
  const ProductState();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductError extends ProductState {
  const ProductError(this.message);
  final String message;
}

class ProductLoaded extends ProductState {
  const ProductLoaded(this.product);
  final Product product;
}

class DetailsCubit extends Cubit<ProductState> {
  DetailsCubit(this._api) : super(ProductLoading());

  final ProductApi _api;

  Future<void> load(int id) async {
    emit(ProductLoading());
    try {
      final product = await _api.getProduct(id);
      if (isClosed) return;
      emit(ProductLoaded(product));
    } on ApiException catch (e) {
      if (!isClosed) emit(ProductError(e.toString()));
    }
  }
}
