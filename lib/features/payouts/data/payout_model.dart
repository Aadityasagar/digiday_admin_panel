
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
  String? name;
  String? phone;
  String? bank_name;
  String? ifsc;
  String? account_holder;
  String? account_number;
  String? wallet;

  Payout({
    this.id,
    this.amount,
    this.status,
    this.walletId,
    this.name,
    this.phone,
    this.bank_name,
    this.ifsc,
    this.account_holder,
    this.account_number,
    this.wallet,
  });


  factory Payout.fromJson(Map<String, dynamic> json) => Payout(
      id: json["id"],
    amount: json["amount"],
    status: json["status"],
    walletId: json["walletId"],
    name: json["name"],
    phone: json["phone"],
    bank_name: json["bank_name"],
    ifsc: json["ifsc"],
    account_number: json["account_number"],
    account_holder: json["account_holder"],
    wallet: json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "status": status,
    "walletId": walletId,
    "name": name,
    "phone": phone,
    "bank_name": bank_name,
    "ifsc": ifsc,
    "account_number": account_number,
    "account_holder": account_holder,
    "wallet": wallet,
  };
}