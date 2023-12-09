import 'dart:convert';

CategoryModel categoryFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryToJson(CategoryModel data) => json.encode(data.toJson());

List<CategoryModel> categoriesFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoriesToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CategoryModel {
  String? id;
  String? categoryName;
  String? categoryIcon;
  String? categoryType;

  CategoryModel({
    this.id,
    this.categoryName,
    this.categoryIcon,
    this.categoryType
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"],
      categoryName: json["categoryName"],
      categoryIcon: json["categoryIcon"],
      categoryType: json["categoryType"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "categoryIcon": categoryIcon,
    "categoryType": categoryType
  };

}