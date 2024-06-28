import 'package:meta/meta.dart';
import 'dart:convert';

class ProductResponseModel {
    final bool success;
    final String message;
    final List<Produk> data;

    ProductResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Produk>.from(json["data"].map((x) => Produk.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Produk {
    final int idProduk;
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

    Produk({
        required this.idProduk,
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

    factory Produk.fromJson(String str) => Produk.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Produk.fromMap(Map<String, dynamic> json) => Produk(
        idProduk: json["id_produk"],
        namaProduk: json["nama_produk"],
        kodeProduk: json["kode_produk"],
        jumlahProduk: json["jumlah_produk"],
        sku: json["sku"],
        sn: json["sn"],
        lisensi1: json["lisensi1"],
        lisensi2: json["lisensi2"],
        divisi: json["divisi"],
        keterangan: json["keterangan"],
        tanggalOrder: json["tanggal_order"],
        tanggalTerima: json["tanggal_terima"],
        tanggalExpired: json["tanggal_expired"],
        posisi: json["posisi"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "id_produk": idProduk,
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