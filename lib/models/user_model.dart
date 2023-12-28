import 'package:digiday_admin_panel/models/subscription.dart';

class UserData {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? isVendor;
  String? photo;
  String? isSubscribed;
  String? referredBy;
  String? referralCode;
  String? address;
  String? city;
  String? state;
  String? pinCode;
  bool? phoneVerified;
  bool? emailVerified;
  Subscription? subscription;
  String? userSubscriptionStatus;

  UserData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.isVendor,
    this.photo,
    this.isSubscribed,
    this.referredBy,
    this.referralCode,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.phoneVerified,
    this.emailVerified,
    this.subscription,
    this.userSubscriptionStatus
  });

}