import 'dart:convert';
import 'package:assignment_9/core/constants/api_constant.dart';
import 'package:assignment_9/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String url = ApiConstants.productsEndpoint;

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<Product> addProduct(Product product) async {
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("unable to add product");
    }
  }

  Future<void> updateProduct(Product product) async {
    var response = await http.put(
      Uri.parse("$url/${product.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update the product");
    }
  }

  Future<void> deleteProduct(String id) async {
    var response = await http.delete(
      Uri.parse("$url/$id"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete the product");
    }
  }
}
