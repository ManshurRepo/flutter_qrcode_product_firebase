// import 'package:meta/meta.dart';
// import 'dart:convert';

// class AuthRegisterRequestModel {
//     final String email;
//     final String password;
//     final String name;

//     AuthRegisterRequestModel({
//         required this.email,
//         required this.password,
//         required this.name,
//     });

//     factory AuthRegisterRequestModel.fromJson(String str) => AuthRegisterRequestModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory AuthRegisterRequestModel.fromMap(Map<String, dynamic> json) => AuthRegisterRequestModel(
//         email: json["email"],
//         password: json["password"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toMap() => {
//         "email": email,
//         "password": password,
//         "name": name,
//     };
// }
import 'dart:convert';

class AuthRegisterRequestModel {
  final String name;
  final String email;
  final String password;

  AuthRegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory AuthRegisterRequestModel.fromJson(String str) =>
      AuthRegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthRegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      AuthRegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
