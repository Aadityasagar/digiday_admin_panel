
import 'dart:convert';

Payout offerFromJson(String str) => Payout.fromJson(json.decode(str));

String offerToJson(Payout data) => json.encode(data.toJson());

List<Payout> offersFromJson(String str) => List<Payout>.from(json.decode(str).map((x) => Payout.fromJson(x)));

String offersToJson(List<Payout> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payout{
  String? id;
  String? amount;
  String? status;
  String? walletId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? bankName;
  String? ifsc;
  String? accountHolder;
  String? accountNumber;
  String? wallet;

  Payout({
    this.id,
    this.amount,
    this.status,
    this.walletId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.bankName,
    this.ifsc,
    this.accountHolder,
    this.accountNumber,
    this.wallet,
  });


  factory Payout.fromJson(Map<String, dynamic> json) => Payout(
    id: json["id"],
    amount: json["amount"],
    status: json["status"],
    walletId: json["walletId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    email: json["email"],
    bankName: json["bankName"],
    ifsc: json["ifsc"],
    accountNumber: json["accountNumber"],
    accountHolder: json["accountHolder"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "status": status,
    "walletId": walletId,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "bankName": bankName,
    "ifsc": ifsc,
    "accountNumber": accountNumber,
    "accountHolder": accountHolder,
    "wallet": wallet,
  };
}