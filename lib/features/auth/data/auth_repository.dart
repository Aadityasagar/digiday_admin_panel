import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/account/data/account_repository.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/data/model/profile.dart';
import 'package:digiday_admin_panel/features/common/data/api_response.dart';
import 'package:digiday_admin_panel/utils/services/network/api_base_helper.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiBaseHelper _apiBaseHelper = Get.find<ApiBaseHelper>();
  final AppSessionController _appState = Get.find<AppSessionController>();
  final preferenceRef = SharedPreferenceRef.instance;
  final AccountRepository _accountRepository = AccountRepository();


  // method to postFCm Token
  Future postFCMToken(String? token) async {
    final Map<String, String> param = {
      'deviceType': "mobile",
    };

    final Map<String, String> header = {
      'Referer': 'https://${_appState.hostUrl}',
      'device_id': _appState.deviceId,
    };
    final Map<String, String> body = {
      'userDeviceToken': token ?? "",
    };
    print("Posting   Token ${token}");
    ApiResponse? response = await _apiBaseHelper.post(
        endpoint: "ApiUrl.postFCMToken",
        body: body,
        param: param,
        additionalHeader: header);
    print("Response ${response?.code}");
  }




  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final Map<String, dynamic> _body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };

    ApiResponse? apiResponse = await _apiBaseHelper.post(
        endpoint: "ApiUrl.kChangeUserPasswordUrl", body: _body);
    if (apiResponse?.code == 1) {
      return ;
    } else {
      throw ApiException(message: apiResponse?.message);
    }
  }

  ///For forgot Password Functionality
  Future resetPassword(
      {required String password,required String emailToken,}) async {
    final Map<String, dynamic> _body = {
      "password": password
    };

    final Map<String, String> header = {
      "email_token":emailToken
    };

    ApiResponse? response = await _apiBaseHelper.post(
        endpoint:" ApiUrl.kResetUserPasswordUrl", body: _body,additionalHeader: header);

    ApiResponse apiResponse = response!;

    if (apiResponse.code == 1) {
      return true;
    } else {
      throw ApiException(message: apiResponse.message);
    }
  }

  //Function used to send the Forgot password request
  Future forgotPassword({required String userEmail}) async {
    final Map<String, dynamic> _body = {
      "captchaResponse": '',
      "email": userEmail,
    };

    ApiResponse? response = await _apiBaseHelper.post(
        endpoint: "ApiUrl.kForgotUserPasswordUrl", body: _body);
    ApiResponse apiResponse = response!;

    if (apiResponse.code == 1) {
      return true;
    } else {
      throw ApiException(message: apiResponse.message);
    }
  }

  ///For VENDOR registration Functionality
  Future registerVendor({required String password,
                        required String email}) async {


    try {

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential != null) {
        return credential.user?.uid;
      } else {
       debugPrint("Not Registered");
      }

    } on FirebaseAuthException catch (e) {
       rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }


  }

Future<void> updateUserData(String? userId,Map<String,dynamic> data)async{
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(data);
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
}

  // Future registerVendor({required String password,
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String phone,
  //   required String businessName,
  //   required String businessAddress,
  //   required String businessCity,
  //   required String businessState,
  //   required String pinCode,
  //   required String referralCode,
  //
  // }) async {
  //   final Map<String, dynamic> _body = {
  //     "firstName":firstName,
  //     "lastName":lastName,
  //     "email":email,
  //     "password":password,
  //     "phone":phone,
  //     "businessName":businessName,
  //     "businessAddress":businessAddress,
  //     "businessCity":businessCity,
  //     "businessState":businessState,
  //     "businessPincode":pinCode,
  //     "referralCode":referralCode
  //   };
  //
  //   final Map<String, String> header = {};
  //
  //   ApiResponse? response = await _apiBaseHelper.post(
  //       endpoint: ApiUrl.kRegisterUserUrl, body: _body,additionalHeader: header);
  //
  //   ApiResponse apiResponse = response!;
  //
  //   if (apiResponse.code == 200) {
  //     return true;
  //   } else {
  //     throw ApiException(message: apiResponse.message);
  //   }
  // }

  /// Api to authenticate user
  Future<bool?> loginUser({required String userEmail, required String pwd}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: pwd
      );

      if(credential!=null){
        Map<dynamic, dynamic>? claims = await FirebaseService().currentUserClaims;
        bool result=false;
        if(claims!=null && (( claims.containsKey('isSuperAdmin') && claims['isSuperAdmin'] ) || ( claims.containsKey('isAdmin') && claims['isAdmin']))){
          result=true;
        } else{
          await FirebaseAuth.instance.signOut();
          result=false;
        }
        return result;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }

  }

  /// 1-> Clear all existing user list
  /// 2-> Set Profile and other User session data to the shared Preference
  Future<void> saveData(data) async {
    //save data to memory
    if(data.containsKey("auth-token")){
      saveToken(data["auth-token"]);
    }

     if(data.containsKey("profileData")){
       ProfileInfo profile=ProfileInfo.fromJson(data['profileData']);
       preferenceRef.setProfileData(profile);
    }

     _appState.checkTokenData();

  }


  /// Save Token to shared preference and load to Session data
  Future<void> saveToken(String token) async {
    await preferenceRef.setTokenData(token);
    _appState.accessToken = token;
  }



  // Logout User
  Future<void> logout() async {
    try {
      ApiResponse? response = await _apiBaseHelper.post(endpoint: "ApiUrl.logout");
      print("response==>${response?.code}");
    } catch (e) {
      rethrow;
    }
  }

  /// Method to remove FCM token
  Future<void> removeFCMToken(String fcmToken) async {
    try {
      ApiResponse? response = await _apiBaseHelper.delete(
          endPoint: "/$fcmToken");
      print("response==>${response?.code}");
    } catch (e) {
      rethrow;
    }
  }



}