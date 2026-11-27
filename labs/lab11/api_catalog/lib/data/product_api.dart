import 'dart:async';
import 'dart:convert';

import 'package:api_catalog/models/product.dart';
import 'package:http/http.dart' as http;

import '../models/product_page.dart';

class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ProductApi {
  ProductApi({Duration? timeout, http.Client? client})
    : _client = client ?? http.Client(),
      _timeout = timeout ?? Duration(seconds: 10);
  final Duration _timeout;
  final http.Client _client;
  static const _host = 'dummyjson.com';

  Future<ProductPage> getProducts({int limit = 20, int skip = 0}) async {
    final uri = Uri.https(_host, '/products', {
      'limit': '$limit',
      'skip': '$skip',
      'delay': '3000',
    });
    return ProductPage.fromJson(await _get(uri));
  }

  Future<Product> getProduct(int id) async {
    final uri = Uri.https(_host, "/products/$id");
    return Product.fromJson(await _get(uri));
  }

  Future<ProductPage> search(String query) async {
    final uri = Uri.https(_host, "/products/search", {"q": query});
    return ProductPage.fromJson(await _get(uri));
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final http.Response response;

    try {
      response = await _client.get(uri).timeout(_timeout);
    } on TimeoutException {
      throw ApiException("Server couldn't answer within timeout limit");
    } on http.ClientException {
      throw ApiException(
        "Something went wrong. Please, check your internet or try again later.",
      );
    }

    if (response.statusCode != 200) {
      throw ApiException("Server answered ${response.statusCode}");
    }

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } on FormatException {
      throw ApiException("Server answered with invalid response");
    }
  }
}
