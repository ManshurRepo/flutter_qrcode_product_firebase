class ProductModel {
  String? sku;
  String? sn;
  String? code;
  String? divisi;
  String? keterangan;
  String? lisensi;
  String? lisensi2;
  String? name;
  String? posisi;
  String? productId;
  int? qty;
  String? status;
  String? expired;
  String? order;
  String? receipt;

  ProductModel({
    this.sku,
    this.sn,
    this.code,
    this.divisi,
    this.keterangan,
    this.lisensi,
    this.lisensi2,
    this.name,
    this.posisi,
    this.productId,
    this.qty,
    this.status,
    this.expired,
    this.order,
    this.receipt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        sku: json["sku"] ?? "-",
        sn: json["sn"] ?? "-",
        code: json["code"] ?? "-",
        divisi: json["divisi"] ?? "-",
        keterangan: json["keterangan"] ?? "-",
        lisensi: json["lisensi"] ?? "-",
        lisensi2: json["lisensi2"] ?? "-",
        name: json["name"] ?? "-",
        posisi: json["posisi"] ?? "-",
        productId: json["productId"] ?? "-",
        qty: json["qty"] ?? "-",
        status: json["status"] ?? "-",
        expired: json["expired"] ?? "-",
        order: json["order"] ?? "-",
        receipt: json["receipt"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "SKU": sku,
        "SN": sn,
        "code": code,
        "divisi": divisi,
        "keterangan": keterangan,
        "lisensi": lisensi,
        "lisensi2": lisensi2,
        "name": name,
        "posisi": posisi,
        "productId": productId,
        "qty": qty,
        "status": status,
        "expired": expired,
        "order": order,
        "receipt": receipt,
      };
}
