// import 'dart:convert';

// class ProductRequestModel {
//   final String namaProduk;
//   final String kodeProduk;
//   final int jumlahProduk;
//   final String sku;
//   final String sn;
//   final String lisensi1;
//   final String lisensi2;
//   final String divisi;
//   final String keterangan;
//   final String tanggalOrder;
//   final String tanggalTerima;
//   final String tanggalExpired;
//   final String posisi;
//   final String status;

  

//   ProductRequestModel({
//     required this.namaProduk,
//     required this.kodeProduk,
//     required this.jumlahProduk,
//     required this.sku,
//     required this.sn,
//     required this.lisensi1,
//     required this.lisensi2,
//     required this.divisi,
//     required this.keterangan,
//     required this.tanggalOrder,
//     required this.tanggalTerima,
//     required this.tanggalExpired,
//     required this.posisi,
//     required this.status,
//   });

//   factory ProductRequestModel.fromJson(String str) =>
//       ProductRequestModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory ProductRequestModel.fromMap(Map<String, dynamic> json) =>
//       ProductRequestModel(
//         namaProduk: json['namaProduk'],
//         kodeProduk: json['kodeProduk'],
//         jumlahProduk: int.parse(json['jumlahProduk']),
//         sku: json['sku'],
//         sn: json['sn'],
//         lisensi1: json['lisensi1'],
//         lisensi2: json['lisensi2'],
//         divisi: json['divisi'],
//         keterangan: json['keterangan'],
//         tanggalOrder: json['tanggalOrder'],
//         tanggalTerima: json['tanggalTerima'],
//         tanggalExpired: json['tanggalExpired'],
//         posisi: json['posisi'],
//         status: json['status'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       'namaProduk': namaProduk,
//       'kodeProduk': kodeProduk,
//       'jumlahProduk': jumlahProduk.toString(),
//       'sku': sku,
//       'sn': sn,
//       'lisensi1': lisensi1,
//       'lisensi2': lisensi2,
//       'divisi': divisi,
//       'keterangan': keterangan,
//       'tanggalOrder': tanggalOrder,
//       'tanggalTerima': tanggalTerima,
//       'tanggalExpired': tanggalExpired,
//       'posisi': posisi,
//       'status': status,
//     };
//   }
// }
import 'dart:convert';

class ProductRequestModel {
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

  ProductRequestModel({
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

  factory ProductRequestModel.fromJson(String str) =>
      ProductRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductRequestModel.fromMap(Map<String, dynamic> json) =>
      ProductRequestModel(
        namaProduk: json['nama_produk'],
        kodeProduk: json['kode_produk'],
        jumlahProduk: json['jumlah_produk'],
        sku: json['sku'],
        sn: json['sn'],
        lisensi1: json['lisensi1'],
        lisensi2: json['lisensi2'],
        divisi: json['divisi'],
        keterangan: json['keterangan'],
        tanggalOrder: json['tanggal_order'],
        tanggalTerima: json['tanggal_terima'],
        tanggalExpired: json['tanggal_expired'],
        posisi: json['posisi'],
        status: json['status'],
      );

  Map<String, dynamic> toMap() {
    return {
      'nama_produk': namaProduk,
      'kode_produk': kodeProduk,
      'jumlah_produk': jumlahProduk,
      'sku': sku,
      'sn': sn,
      'lisensi1': lisensi1,
      'lisensi2': lisensi2,
      'divisi': divisi,
      'keterangan': keterangan,
      'tanggal_order': tanggalOrder,
      'tanggal_terima': tanggalTerima,
      'tanggal_expired': tanggalExpired,
      'posisi': posisi,
      'status': status,
    };
  }
}

