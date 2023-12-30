


import 'package:digiday_admin_panel/models/orderItem_model.dart';

class OrderBody{
  List<OrderItem>? orderItems;

  OrderBody({
    this.orderItems
  });


  factory OrderBody.fromJson(Map<String, dynamic> json) => OrderBody(
      orderItems: orderItemsFromJson(json)
  );

  Map<String, dynamic> toJson() => {
    "orderItems": orderItems
  };
}


class OrderData{
  String? id;
  OrderBody? orderBody;
  String? userId;
  String? businessId;
  String? businessName;
  String? businessAddress;
  int? totalAmount;
  int? createdAt;
  String? orderStatus;
  String? paymentStatus;
  String? paymentMode;


  OrderData({
    this.id,
    this.orderBody,
    this.userId,
    this.businessId,
    this.businessName,
    this.businessAddress,
    this.totalAmount,
    this.createdAt,
    this.orderStatus,
    this.paymentStatus,
    this.paymentMode,
  });


  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id:json['id'],
    orderBody: OrderBody.fromJson(json["orderBody"]),
    userId: json["userId"],
    businessId: json["businessId"],
    businessName: json["businessName"],
    businessAddress: json["businessAddress"],
    totalAmount: json["totalAmount"],
    createdAt: json["createdAt"],
    orderStatus: json["orderStatus"],
    paymentStatus: json["paymentStatus"],
    paymentMode: json["paymentMode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderBody": orderBody,
    "userId": userId,
    "businessId": businessId,
    "businessName": businessName,
    "businessAddress": businessAddress,
    "totalAmount": totalAmount,
    "createdAt": createdAt,
    "orderStatus": orderStatus,
    "paymentStatus": paymentStatus,
    "paymentMode": paymentMode,
  };
}


