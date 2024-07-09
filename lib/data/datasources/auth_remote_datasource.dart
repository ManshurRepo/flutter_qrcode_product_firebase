import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_scanqr/constants/variables.dart';
import 'package:flutter_scanqr/data/datasources/auth_local_datasource.dart';
import 'package:flutter_scanqr/data/models/request/auth_register_request_model.dart';
import 'package:flutter_scanqr/data/models/request/login_request_model.dart';
import 'package:http/http.dart' as http;
import '../models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      AuthRegisterRequestModel registerRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerRequestModel.toMap()),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('register gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${authData?.accessToken}',
        });

    if (response.statusCode == 200) {
      return const Right('logout berhasil');
    } else {
      return const Left('logout gagagl');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: data.toJson(),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left("Login Gagal");
    }
  }

}
