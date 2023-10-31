import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/auth/views/log_in/sign_in_screen.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  RxBool isLoading= false.obs;
  final GlobalKey<FormState> forgotForm = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();


  @override
  void onInit() {
    // TODO: implement onIni
    super.onInit();
  }


  Future<void> forgotPassword() async {
    isLoading.value=true;
    try{
      bool? result=await FirebaseService.forgotPassword(email: email.text);
      if(result){
        Get.offAll(()=> LogInScreen());
      }
      else{
        return CommonFunctions.showDialogBox(
          popupType: PopupType.error,
          message: "Account not found!",
          actions: [
            ActionButton("Ok", () {
              Get.back();
            })
          ],
        );
      }
    }on FirebaseException catch(e){
      debugPrint(e.message);
    }
    finally{
      email.clear();
      isLoading.value=false;
    }

  }

  void validateAndSubmit() async {
    if (forgotForm.currentState!.validate()) {
      await forgotPassword();
    } else {
      update();
    }
  }
}