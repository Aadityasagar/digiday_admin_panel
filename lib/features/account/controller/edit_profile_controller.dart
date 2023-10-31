
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:digiday_admin_panel/features/account/data/account_repository.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/data/model/profile.dart';
import 'package:digiday_admin_panel/features/auth/views/log_in/sign_in_screen.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/services/city_service.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/state_service.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController{
  final AccountRepository _accountRepository = AccountRepository();
  final AppSessionController _appState = Get.find<AppSessionController>();
  final AccountController _accountController = Get.find<AccountController>();

  RxBool isPasswordIcon1 = false.obs;
  RxBool isPasswordIcon2 = false.obs;

  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isLoading = false.obs;




  final GlobalKey<FormState> prifileform = GlobalKey<FormState>();
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();




  @override
  void onReady() {
    super.onReady();
    setDeafultValues();
    readArguments();
  }

  setDeafultValues(){
    firstName.text=_accountController.getCurrentUser?.firstName??"";
    lastName.text=_accountController.getCurrentUser?.lastName??"";
    email.text=_accountController.getCurrentUser?.email??"";
    phone.text=_accountController.getCurrentUser?.phone??"";
    addressController.text=_accountController.getCurrentUser?.address??"";
    cityController.text=_accountController.getCurrentUser?.city??"";
    stateController.text=_accountController.getCurrentUser?.state??"";
    pincodeController.text=_accountController.getCurrentUser?.pinCode??"";
  }



  ///This method reads all arguments which were passed in route
  void readArguments() {

  }




  ///Method for rest password api call
  Future<void> updatePersonalDetails() async {
    try {
      isLoading.value = true;

      await _accountRepository.updatePersonalDetails(
          firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        phone: phone.text,
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        pincode: pincodeController.text
      );


      await CommonFunctions.showDialogBox(
        popupType: PopupType.success,
        message: "Profile details updated!",
        actions: [
          ActionButton("Ok".tr, () {
            _accountController.fetchProfileData();
            Get.back();
          })
        ],
      );

      isLoading.value = false;
    } on ApiException catch (e) {

      if(e.status==ApiExceptionCode.sessionExpire){
        CommonFunctions.showSnackBar(title: "Alert", message: "Session Expired", type: PopupType.error);
        Get.offAll(()=> LogInScreen());
      }

      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: e.message,
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

  void updateProfileDataInLocalStorage(){
    ProfileInfo? profileData=_appState.getProfileInfo;
    profileData?.firstName=firstName.text;
    profileData?.lastName=lastName.text;
    profileData?.email=email.text;
    profileData?.phone=phone.text;

    SharedPreferenceRef.instance.setProfileData(profileData!);
  }

  void validateAndSubmit() async {
     if (prifileform.currentState!.validate()) {
      await updatePersonalDetails();
    } else {
      update();
    }
  }


  void onTapoutSide(){
    if(cityController.text!=null && CitiesService.isSelectedCityNotInList(cityController.text)==true){
      cityController.clear();
    }
  }


  String? cityFieldValidator(String? value) {
    String? errorMsg;
    if (value==null || value=="") {
      errorMsg="City can't be empty";
    } else if (CitiesService.cities.contains(value)==false) {
      errorMsg="City is not valid kindly select from list.";
    }
    return errorMsg;
  }

  String? stateFieldValidator(String? value) {
    String? errorMsg;
    if (value==null || value=="") {
      errorMsg="State can't be empty";
    } else if (StatesService.states.contains(value)==false) {
      errorMsg="State is not valid kindly select from list.";
    }
    return errorMsg;
  }



}