import 'package:digiday_admin_panel/features/auth/data/auth_repository.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_pref_keys.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final AuthRepository _authRepository = AuthRepository();

  RxBool isPasswordIcon1 = false.obs;
  RxBool isObscure1 = true.obs;

  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;
  RxBool alreadyUser = false.obs;


  final GlobalKey<FormState> emailLoginForm = GlobalKey<FormState>();

  TextEditingController email=TextEditingController(text: "webearlydotin@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "User@1234567");

  @override
  void onReady() {
    setDefaults();
    super.onReady();
  }

  void setDefaults()async{
    bool? _rememberMe=await SharedPreferenceRef.instance.getRememberMeStatus();
    if(_rememberMe!=null && _rememberMe!=false){
      rememberMe.value=true;
      String? _email = await  SharedPreferenceRef.instance.getEmail();
      email.text=_email;
    }
  }



  ///Method for login vendor api call
  Future<void> loginAdminWithEmail() async {
    try {
    isLoading.value = true;
    bool? response =  await _authRepository.loginUser(
        userEmail: email.text,
        pwd: passwordController.text
      );

    if(response!=null && response){

      if(rememberMe.value){
        SharedPreferenceRef.instance.setRememberMeStatus(true);
        SharedPreferenceRef.instance.setEmail(email.text);
      }
      else{
        SharedPreferenceRef.instance.setRememberMeStatus(false);
        SharedPreferenceRef.instance.removeValue(key:SharedPrefsKeys.kSPEmail);
      }
      Get.offAllNamed(
        AppRoutes.homeScreen,
      );
    }
    else if(response!=null && response==false){
      ///user is already registered
      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: "User is not allowed to access this app.",
        actions: [
          ActionButton("Ok", () {
            Get.back();
          })
        ],
      );
    }


      isLoading.value = false;
    }  on FirebaseAuthException catch (e) {

      String msg="";

      if (e.code == 'user-not-found') {
        msg='No user found for that email.';
      }
      else if (e.code == 'wrong-password') {
        msg='Wrong password provided for that user.';
      }
      else if(e.code =='INVALID_LOGIN_CREDENTIALS'){
        msg='Invalid login credentials provided.';
      }
      else if(e.code =='network-request-failed'){
        msg='You are not connected to internet.';
      }

      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: msg,
        actions: [
          ActionButton("Ok", () {
            Get.back();
          })
        ],
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void validateAndSubmit() async {
    if (emailLoginForm.currentState!.validate()) {
      await loginAdminWithEmail();
    } else {
      update();
    }
  }




}