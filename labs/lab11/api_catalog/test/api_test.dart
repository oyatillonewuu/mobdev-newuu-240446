import 'dart:convert';
import 'dart:io';

import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/models/product_page.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test("it retuns one product in product page", () async {
    final String testJson = File("./test/fixtures/product.json")
        .readAsStringSync();
    final testLimit = 30;
    final testSkip = 0;

    final MockClient client = MockClient((request) {
      return Future(
        () => Response(
          jsonEncode({
            "products": [jsonDecode(testJson)],
            "total": 1,
            "limit": testLimit,
            "skip": testSkip,
          }),
          200,
          headers: {"Content-Type": "application/json"},
        ),
      );
    });

    final ProductApi api = ProductApi(client: client);

    final ProductPage productPage = await api.getProducts(
      limit: testLimit,
      skip: testSkip,
    );

    expect(productPage.products.length, 1);
  });

  test("it throws ApiException on 404 response", () async {
    final MockClient client = MockClient((request) {
      return Future(() => Response("page not found", 404));
    });

    final ProductApi api = ProductApi(client: client);

    expect(() async => await api.getProduct(0), throwsException);
  });
}
