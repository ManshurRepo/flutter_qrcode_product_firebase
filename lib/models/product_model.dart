
class Product {
    String? code;
    String? name;
    String? productId;
    int? qty;

    Product({
        this.code,
        this.name,
        this.productId,
        this.qty,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        productId: json["productId"] ?? "",
        qty: json["qty"] ?? 0 ,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "productId": productId,
        "qty": qty,
    };
}
