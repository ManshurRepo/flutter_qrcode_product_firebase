import 'package:meta/meta.dart';
import 'dart:convert';

class AddProductResponseModel {
  final bool success;
  final String message;
  final List<AddProduk> data;

  AddProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddProductResponseModel.fromJson(String str) => AddProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductResponseModel.fromMap(Map<String, dynamic> json) => AddProductResponseModel(
        success: json["success"] ?? false, // Provide a default value
        message: json["message"] ?? '', // Provide a default value
        data: json["data"] != null
            ? List<AddProduk>.from(json["data"].map((x) => AddProduk.fromMap(x)))
            : [], // Provide a default value
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class AddProduk {
  final String namaProduk;
  final String kodeProduk;
  final int jumlahProduk;
  final String sku;
  final String sn;
  final String lisensi1;
  final String lisensi2;
  final String divisi;
  final String keterangan;
  final String tanggalOrder;
  final String tanggalTerima;
  final String tanggalExpired;
  final String posisi;
  final String status;

  AddProduk({
    required this.namaProduk,
    required this.kodeProduk,
    required this.jumlahProduk,
    required this.sku,
    required this.sn,
    required this.lisensi1,
    required this.lisensi2,
    required this.divisi,
    required this.keterangan,
    required this.tanggalOrder,
    required this.tanggalTerima,
    required this.tanggalExpired,
    required this.posisi,
    required this.status,
  });

  factory AddProduk.fromJson(String str) => AddProduk.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProduk.fromMap(Map<String, dynamic> json) => AddProduk(
        namaProduk: json["nama_produk"] ?? '', // Provide a default value
        kodeProduk: json["kode_produk"] ?? '', // Provide a default value
        jumlahProduk: json["jumlah_produk"] ?? 0, // Provide a default value
        sku: json["sku"] ?? '', // Provide a default value
        sn: json["sn"] ?? '', // Provide a default value
        lisensi1: json["lisensi1"] ?? '', // Provide a default value
        lisensi2: json["lisensi2"] ?? '', // Provide a default value
        divisi: json["divisi"] ?? '', // Provide a default value
        keterangan: json["keterangan"] ?? '', // Provide a default value
        tanggalOrder: json["tanggal_order"] ?? '', // Provide a default value
        tanggalTerima: json["tanggal_terima"] ?? '', // Provide a default value
        tanggalExpired: json["tanggal_expired"] ?? '', // Provide a default value
        posisi: json["posisi"] ?? '', // Provide a default value
        status: json["status"] ?? '', // Provide a default value
      );

  Map<String, dynamic> toMap() => {
        "nama_produk": namaProduk,
        "kode_produk": kodeProduk,
        "jumlah_produk": jumlahProduk,
        "sku": sku,
        "sn": sn,
        "lisensi1": lisensi1,
        "lisensi2": lisensi2,
        "divisi": divisi,
        "keterangan": keterangan,
        "tanggal_order": tanggalOrder,
        "tanggal_terima": tanggalTerima,
        "tanggal_expired": tanggalExpired,
        "posisi": posisi,
        "status": status,
      };
}
