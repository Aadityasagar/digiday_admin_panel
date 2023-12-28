// To parse this JSON data, do
//
//     final vendorPlan = vendorPlanFromJson(jsonString);

import 'dart:convert';

List<VendorPlan> vendorPlanFromJson(String str) => List<VendorPlan>.from(json.decode(str).map((x) => VendorPlan.fromJson(x)));

String vendorPlanToJson(List<VendorPlan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorPlan {
  String? id;
  String? planName;
  int? planValidity;
  int? planPrice;
  DateTime? createdAt;

  VendorPlan({
    this.id,
    this.planName,
    this.planValidity,
    this.planPrice,
    this.createdAt,
  });

  factory VendorPlan.fromJson(Map<String, dynamic> json) => VendorPlan(
    id: json["_id"],
    planName: json["planName"],
    planValidity: json["planValidity"],
    planPrice: json["planPrice"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "planName": planName,
    "planValidity": planValidity,
    "planPrice": planPrice,
    "createdAt": createdAt?.toIso8601String(),
  };
}
