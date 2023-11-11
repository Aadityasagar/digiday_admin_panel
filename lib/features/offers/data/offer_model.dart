import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

List<Offer> offersFromJson(String str) => List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

String offersToJson(List<Offer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offer{
  String? id;
  String? offerTitle;
  String? description;
  String? offerType;
  String? discountAmount;
  String? offerCode;
  String? offerBanner;

  Offer({
    this.id,
    this.offerTitle,
    this.description,
    this.offerType,
    this.discountAmount,
    this.offerCode,
    this.offerBanner
   });


  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    offerTitle: json["offerTitle"],
    description: json["description"],
    offerType: json["offerType"],
    discountAmount: json["discountAmount"],
    offerCode: json["offerCode"],
    offerBanner: json["offerBanner"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offerTitle": offerTitle,
    "description": description,
    "offerType": offerType,
    "discountAmount": discountAmount,
    "offerCode": offerCode,
    "offerBanner": offerBanner
  };
}