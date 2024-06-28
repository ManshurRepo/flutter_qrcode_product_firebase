import 'package:dartz/dartz.dart';


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
}
