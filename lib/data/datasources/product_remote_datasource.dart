
import 'package:dartz/dartz.dart';
import 'package:flutter_scanqr/data/models/request/edit_product_request_model.dart';
import 'package:flutter_scanqr/data/models/request/product_request_model.dart';
import 'package:flutter_scanqr/data/models/response/add_product_response_model.dart';

import 'package:http/http.dart' as http;

import '../../constants/variables.dart';
import '../models/response/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/produk'),
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddProductResponseModel>> createProduct(
      ProductRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/produk'),
      body: data.toJson(), // Encode data as JSON
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    print('Response headers: ${response.headers}');

    if (response.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, AddProductResponseModel>> updateProduk( int id,
      EditProductRequestModel data) async {
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/produk/$id'),
      body: data.toJson(), // Encode data as JSON
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    print('Response headers: ${response.headers}');

    if (response.statusCode == 200) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }

  Future<Either<String, AddProductResponseModel>> deleteProduk ( int id)
      async {
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/produk/$id'),
   
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    print('Response headers: ${response.headers}');

    if (response.statusCode == 200) {
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
