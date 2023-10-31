
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TwoFactor extends GetxController{
  AccountController _accountController=Get.find<AccountController>();
  RxBool isLoading=false.obs;
  RxBool isOtpSent=false.obs;

  TextEditingController otpField=TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    //checkIfPhoneVerified();
    super.onInit();
  }


  void checkIfPhoneVerified(){
    bool? isPhoneVerified=_accountController.getCurrentUser?.phoneVerified;
    if(isPhoneVerified!=null && isPhoneVerified==false){
      // Get.bottomSheet(
      //   PhoneVerificationSheet(),
      //   isDismissible: false,
      // );
    }
  }

  void sendOtp()async{
    isLoading.value=true;
    try{
      String phone=_accountController.getCurrentUser?.phone??"";
      await FirebaseService.fireAuth.verifyPhoneNumber(
        phoneNumber: '+91 $phone',
        verificationCompleted: (PhoneAuthCredential credential) {
          Get.back();
        },
        verificationFailed: (FirebaseAuthException e) {

        },
        codeSent: (String verificationId, int? resendToken) {
          isOtpSent.value=true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {

        },
      );


      }
      on FirebaseException catch (e){
      debugPrint(e.message);
     }
    finally{
      isLoading.value=false;
    }
  }

}