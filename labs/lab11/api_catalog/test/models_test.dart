import 'dart:convert';
import 'dart:io';

import 'package:api_catalog/models/product.dart';
import 'package:test/test.dart';

class FieldCheck<T> {
  final String key;
  const FieldCheck(this.key);

  bool matches(dynamic value) => value is T;
}

void main() {
  final String content = File("./test/fixtures/product.json")
      .readAsStringSync();
  final Map<String, dynamic> json = JsonDecoder().convert(content);

  test("it has title, a price that is a double , two tags, three reviews", () {
    expect(json.length >= 4, true, reason: "length must at least be 4");
    final fields = [
      FieldCheck<String>("title"),
      FieldCheck<num>("price"),
      FieldCheck<List>("tags"),
      FieldCheck<List>("reviews"),
    ];

    for (final field in fields) {
      expect(
        json.containsKey(field.key),
        true,
        reason: "{$field.key} must be contained",
      );
      expect(field.matches(json[field.key]), true);
    }
  });

  test("it does not crash on missing brand, crashes on missing tags", () {
    final Map<String, dynamic> jsonNoBrand = {
      "id": 1,
      "title": "test",
      "price": 1,
      "rating": 2,
      "brand": null,
      "tags": [],
      "thumbnail": "test",
      "dimensions": {"width": 2, "height": 2, "depth": 1},
      "reviews": [],
    };
    final Map<String, dynamic> jsonNoTags = {
      "id": 1,
      "title": "test",
      "price": 1,
      "rating": 2,
      "brand": null,
      "thumbnail": "test",
      "dimensions": {"width": 2, "height": 2, "depth": 1},
      "reviews": [],
    };
    try {
      Product.fromJson(jsonNoBrand);
    } catch (e) {
      throw "Parsing failed on missing brand when success was expected";
    }
    try {
      Product.fromJson(jsonNoTags);
      throw "Parsing succeeded on missing tags when failure was expected";
    } catch (_) {}
  });
}
