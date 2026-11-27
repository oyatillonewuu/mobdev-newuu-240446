import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';

final sampleValidProduct = {
  "id": 1,
  "title": "test",
  "description": "test",
  "price": 1,
  "rating": 2,
  "brand": null,
  "tags": [],
  "thumbnail": "test",
  "dimensions": {"width": 2, "height": 2, "depth": 1},
  "reviews": [],
};

MockClient getProductsFakeClient({
  List<Map<String, dynamic>>? products,
  Duration delay = Duration.zero,
  int limit = 20,
  int skip = 0,
}) {
  products ??= [sampleValidProduct];
  return MockClient(
    (req) => Future.delayed(
      delay,
      () => Response(
        jsonEncode({
          "products": [sampleValidProduct],
          "total": 1,
          "limit": limit,
          "skip": skip,
        }),
        200,
      ),
    ),
  );
}
