import 'dart:convert';

ProfileInfo profileInfoFromJson(String str) => ProfileInfo.fromJson(json.decode(str));

String profileInfoToJson(ProfileInfo data) => json.encode(data.toJson());

class ProfileInfo {
  bool? phoneVerified;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? businessName;
  String? businessAddress;
  String? businessCity;
  String? businessState;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? profilePic;

  ProfileInfo({
    this.phoneVerified,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.businessName,
    this.businessAddress,
    this.businessCity,
    this.businessState,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profilePic,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
    phoneVerified: json["phoneVerified"],
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    businessName: json["businessName"],
    businessAddress: json["businessAddress"],
    businessCity: json["businessCity"],
    businessState: json["businessState"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "phoneVerified": phoneVerified,
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "businessName": businessName,
    "businessAddress": businessAddress,
    "businessCity": businessCity,
    "businessState": businessState,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "profilePic": profilePic,
  };
}



