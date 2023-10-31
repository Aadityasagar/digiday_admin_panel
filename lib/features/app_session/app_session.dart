import 'package:digiday_admin_panel/enums.dart';
import 'package:digiday_admin_panel/features/auth/data/model/profile.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_ip_address/get_ip_address.dart';

class AppSessionController extends GetxController {
  String? hostUrl;
  double buildVersion = 3.12;
  late bool isDefaultUrl;
  late String deviceId;
  String? fcmToken;
  late bool isInternalLogin;
  ProfileInfo? _profileInfo;
  String? _subStatus="Inactive";
  String? _nextRechargeDate;
  String? lastPendingOrder;



  String? _accessToken;
  Map<String, dynamic>? deviceInfo;

  ProfileInfo? get getProfileInfo => _profileInfo;

  String? get accessToken => _accessToken;

  String? get subStatus => _subStatus;
  String? get nextRechargeDate => _nextRechargeDate;

  MenuState selectedMenu = MenuState.home;



  set setProfileInfo(ProfileInfo? value) {
    _profileInfo = value;
  }

  set accessToken(String? value) {
    _accessToken = value;
  }

  set setSubStatus(String? value) {
    _subStatus = value;
  }

  set setNextRechargeDate(String? value) {
    _nextRechargeDate = value;
  }


  void clearAppState({bool clearBaseUrl = false}) {
    _profileInfo = null;
    isInternalLogin = false;
    _accessToken = null;
  }

  @override
  void onInit() {
    checkLastPendingOrder();
    super.onInit();
  }


  void checkLastPendingOrder() async{
    String? order=await SharedPreferenceRef.instance.getLastPendingOrder();
    if(order!=null){
      lastPendingOrder=order;
    }
  }

  void checkTokenData()async{
   String? token= await SharedPreferenceRef.instance.getTokenData();
   debugPrint(token);
   if(token!=null){
    _accessToken= token;
   }

   ProfileInfo? profile=await SharedPreferenceRef.instance.getProfileData();
   if(profile!=null){
     _profileInfo=profile;
   }
  }


  void setLocalIp()async{
    var ipAddress = IpAddress();
    String ip = await ipAddress.getIpAddress();
    debugPrint("Current Ip--> $ip");
  }




  Future<bool> isUserLoggedIn()async{
     return FirebaseAuth.instance.currentUser?.uid!=null ? true:false;
  }

  Future<String?> getLoggedInUsersUid() async{
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<Map<dynamic, dynamic>?> get currentUsersClaims async {
    final user = FirebaseAuth.instance.currentUser;
    // if refresh is set to true, a refresh of the id token is forced.
    final IdTokenResult? idtokenresult = await user?.getIdTokenResult(true);
    return idtokenresult?.claims;
  }
}