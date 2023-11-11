
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/data/auth_repository.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdminController extends GetxController{
  final AuthRepository _authRepository = AuthRepository();
  final AppSessionController _appState = Get.find<AppSessionController>();

  RxBool isPasswordIcon1 = false.obs;
  RxBool isPasswordIcon2 = false.obs;

  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isLoading = false.obs;




  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> formBusiness = GlobalKey<FormState>();
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void onReady() {
    super.onReady();
    readArguments();
  }



  ///This method reads all arguments which were passed in route
  void readArguments() {
    // var data = Get.arguments;
    // if (data != null) {
    //   referer = data['referer'];
    //   getParamsFromUrl();
    // }
  }







  ///Method for rest password api call
  Future<void> addAdmin() async {
    try {
      isLoading.value = true;

      String? userId= await _authRepository.registerVendor(email: email.text,
          password: passwordController.text
      );

      if(userId!=null){
        await makeUserAdmin(email.text,phone.text,userId!);
        //show success dialog and wait for 2 seconds then navigate the user to Login Screen
        await CommonFunctions.showDialogBox(
          popupType: PopupType.success,
          message: "Admin Added Successfully!",
          actions: [
            ActionButton("Ok".tr, () {
              Get.back();

            })
          ],
        );
      }
      else{
        return CommonFunctions.showDialogBox(
          popupType: PopupType.error,
          message: "Not Added!",
          actions: [
            ActionButton("Ok", () {
              Get.back();
            })
          ],
        );
      }

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      String msg="";
      if (e.code == 'weak-password') {
        msg='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        msg='The account already exists for that email.';
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
    }finally {
      isLoading.value = false;
      update();
    }
  }


  void validateAndAddAdmin() async {
    //_passwordConfigService.validateFields(newPasswordController.text);
    if (form.currentState!.validate()) {
      await addAdmin();
    } else {
      update();
    }
  }


  Future<void> makeUserAdmin(String email,
      String phone,
      String userId)async{

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'addAdminRole',
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 30),
      ),
    );

    final resp = await callable.call(<String, dynamic>{
      'email': email,
    });

    if(resp.data!=null){

      String uniqueCode=await generateUniqueCode();
      FirebaseFirestore.instance.collection('users').doc(userId).set({
        'isVendor': false,
        'isCm': false,
        'isSuperAdmin': false,
        'isAdmin': true,
        'email': email,
        'phone': phone,
        'firstName': firstName.text,
        'lastName': lastName.text,
        'phoneVerified': false,
        'emailVerified': false,
        'referralCode': uniqueCode
      });
    }


  }

  String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<bool> checkIfCodeIsUnique(String code)async{
    QuerySnapshot? snapshot = await FirebaseFirestore.instance.collection('users').where('referralCode',isEqualTo: code).get();
    // if (snapshot?.docs != null) {
    //   QueryDocumentSnapshot<Object?>? businessData = snapshot?.docs.first;
    // }
    return snapshot?.docs == null?true:false;
  }

  Future<String> generateUniqueCode()async{
    String code = getRandomString(6);
    bool isCodeUnique=await checkIfCodeIsUnique(code);
    if(isCodeUnique==false){
      generateUniqueCode();
    }
    return code;
  }



}