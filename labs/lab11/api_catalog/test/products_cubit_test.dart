import 'package:api_catalog/cubit/products_cubit.dart';
import 'package:api_catalog/data/product_api.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

import 'fake_client.dart';

void main() {
  final successMockApi = ProductApi(
    client: getProductsFakeClient(),
    timeout: Duration(milliseconds: 200),
  );
  final failMockApi = ProductApi(
    client: getProductsFakeClient(delay: Duration(milliseconds: 201)),
    timeout: Duration(milliseconds: 200),
  );

  blocTest<ProductsCubit, ProductsState>(
    "success emits [ProductsLoading, ProductsLoaded]",
    build: () => ProductsCubit(successMockApi),
    act: (bloc) => bloc.load(),
    expect: () => [isA<ProductsLoading>(), isA<ProductsLoaded>()],
  );

  blocTest<ProductsCubit, ProductsState>(
    "fail emits [ProductsLoading, ProductsError]",
    build: () => ProductsCubit(failMockApi),
    act: (bloc) => bloc.load(),
    expect: () => [isA<ProductsLoading>(), isA<ProductsError>()],
  );
}
