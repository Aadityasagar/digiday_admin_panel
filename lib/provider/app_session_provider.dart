import 'package:digiday_admin_panel/enums.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_ip_address/get_ip_address.dart';

class AppSessionProvider extends ChangeNotifier{

  String? hostUrl;
  double buildVersion = 3.12;
  late bool isDefaultUrl;
  late String deviceId;
  String? fcmToken;
  late bool isInternalLogin;
  String? _subStatus="Inactive";
  String? _nextRechargeDate;
  String? lastPendingOrder;



  String? _accessToken;
  Map<String, dynamic>? deviceInfo;


  String? get accessToken => _accessToken;

  String? get subStatus => _subStatus;
  String? get nextRechargeDate => _nextRechargeDate;

  MenuState selectedMenu = MenuState.home;



  set accessToken(String? value) {
    _accessToken = value;
  }

  set setSubStatus(String? value) {
    _subStatus = value;
  }

  set setNextRechargeDate(String? value) {
    _nextRechargeDate = value;
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