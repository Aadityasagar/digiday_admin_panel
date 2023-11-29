import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

List<Product> productsFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productsToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product{
  String? id;
  String? productTitle;
  String? productDescription;
  String? productBrand;
  String? productCategory;
  String? productRegularPrice;
  String? productSalePrice;
  String? productImage;
  List<dynamic>? productImageGallery;

  Product({
    this.id,
    this.productTitle,
    this.productDescription,
    this.productBrand,
    this.productCategory,
    this.productRegularPrice,
    this.productSalePrice,
    this.productImage,
    this.productImageGallery
  });


  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      productTitle: json["productTitle"],
      productDescription: json["productDescription"],
      productBrand: json["productBrand"],
      productCategory: json["productCategory"],
      productRegularPrice: json["productRegularPrice"],
      productSalePrice: json["productSalePrice"],
      productImage: json["productImage"],
      productImageGallery: json["productImageGallery"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productTitle": productTitle,
    "productDescription": productDescription,
    "productBrand": productBrand,
    "productCategory": productCategory,
    "productRegularPrice": productRegularPrice,
    "productSalePrice": productSalePrice,
    "productImage": productImage,
    "productImageGallery": productImageGallery
  };
}