import 'dart:convert';
import 'dart:io';

import 'package:api_catalog/data/product_api.dart';
import 'package:api_catalog/models/product_page.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'fake_client.dart';

void main() {
  final String testJson = File("./test/fixtures/product.json")
      .readAsStringSync();
  final testLimit = 30;
  final testSkip = 0;
  final testBody = jsonEncode({
    "products": [jsonDecode(testJson)],
    "total": 1,
    "limit": testLimit,
    "skip": testSkip,
  });
  final testHeaders = {"Content-Type": "application/json"};

  test("it retuns one product in product page", () async {
    final ProductApi api = ProductApi(client: getProductsFakeClient());

    final ProductPage productPage = await api.getProducts(
      limit: testLimit,
      skip: testSkip,
    );

    expect(productPage.products.length, 1);
  });

  test("it throws ApiException on 404 response", () async {
    final MockClient client = MockClient((request) {
      return Future(
        () => Response(
          jsonEncode({"message": "page not found"}),
          404,
          headers: testHeaders,
        ),
      );
    });

    final ProductApi api = ProductApi(client: client);

    expect(() async => await api.getProduct(0), throwsA(isA<ApiException>()));
  });

  test("it throws ApiException on timeout", () async {
    final Duration timeout = Duration(milliseconds: 300);
    final MockClient client = MockClient((request) {
      return Future.delayed(
        Duration(milliseconds: timeout.inMilliseconds + 1),
        () => Response(testBody, 200, headers: testHeaders),
      );
    });

    final ProductApi api = ProductApi(client: client, timeout: timeout);
    expect(() async => await api.getProducts(), throwsA(isA<ApiException>()));
  });

  test("it throws ApiException on invalid non-json body", () async {
    final MockClient client = MockClient((request) {
      return Future(
        () => Response("oh, not a json!", 200, headers: testHeaders),
      );
    });
    final ProductApi api = ProductApi(client: client);
    expect(() async => await api.getProducts(), throwsA(isA<ApiException>()));
  });
}
