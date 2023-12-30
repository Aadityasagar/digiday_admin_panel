


import 'dart:convert';

import 'package:digiday_admin_panel/models/Product.dart';

OrderItem orderItemFromJson(String str) => OrderItem.fromJson(json.decode(str));
String orderItemToJson(OrderItem data) => json.encode(data.toJson());



List<OrderItem> orderItemsFromJson(Map<String, dynamic> data) => (data['orderItems'] as List<dynamic>? ?? []).map((x) => OrderItem.fromJson(x)).toList();

Map<String, dynamic> orderItemsToJson(List<OrderItem> data) {
  return {
    'orderItems': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class OrderItem{
  String? orderItemId;
  int? orderItemQuantity;
  Product? productDetails;

  OrderItem({
    this.orderItemId,
    this.orderItemQuantity,
    this.productDetails,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    orderItemId: json["orderItemId"],
    orderItemQuantity: json["orderItemQuantity"],
    productDetails: null,
  );

  Map<String, dynamic> toJson() => {
    "orderItemId": orderItemId,
    "orderItemQuantity": orderItemQuantity,
    "productDetails": null,
  };
}