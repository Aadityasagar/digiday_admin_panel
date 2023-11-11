import 'dart:io';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/account/data/account_repository.dart';
import 'package:digiday_admin_panel/features/account/data/models/user_model.dart';
import 'package:digiday_admin_panel/features/account/view/refferal_code_sheet.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/views/log_in/sign_in_screen.dart';
import 'package:digiday_admin_panel/features/auth/views/register_admin/update_personal_details.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController{
  final AccountRepository _accountRepository = AccountRepository();
  final AppSessionController _appState = Get.find<AppSessionController>();
  final ImagePicker profilePicPicker = ImagePicker();

  RxBool isLoading= false.obs;

  RxString profilePicUrl="".obs;

  UserData? _currentUser;

  UserData? get getCurrentUser => _currentUser;

  set setCurrentUser(UserData? value) {
    _currentUser = value;
  }

  TextEditingController referralCode=TextEditingController();


  void selectProfilePic() async{
    isLoading.value=true;
    final XFile? selectedImage = await profilePicPicker.pickImage(source: ImageSource.gallery);
    if (selectedImage!=null){
      String? result = await _accountRepository.profilePicUpload(File(selectedImage.path));
      if(result!=null){
        updateProfileData(result);
      }
      else{
        Get.snackbar("Error!", "Image not uploaded!");
        isLoading.value=false;
      }
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void fetchimg()async{
    if(_currentUser?.photo!=null){
      profilePicUrl.value = await downloadURLExample("${ApiUrl.profilePicsFolder}/${_currentUser?.photo}");
    }
  }


  Future<void> updateProfileData(String image)async{
    _currentUser?.photo=image;
    Map<String,dynamic> _dataToUpdate={
    'photo': image
    };

    String? curentUUid=await FirebaseService.getLoggedInUserUuId();

    if(curentUUid!=null){
      await FirebaseService.updateDocById(_dataToUpdate, curentUUid, FirebaseKeys.usersCollection);
      fetchimg();
    }

    isLoading.value=false;
  }


  Future<String> downloadURLExample(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }


  Future<void> fetchProfileData() async {
    try{
      UserData? userData=await _accountRepository.fetchProfileData();
      if(userData!=null){
        setCurrentUser=userData;
        fetchimg();
        if(userData.address==null){
         // Get.to(()=> UpdatePersonalDetails());
        }
      }
      else{
        print("Users personal data not available");
        Get.to(()=> UpdatePersonalDetails());
      }
    }
    on ApiException catch(e){
     if(e.status==ApiExceptionCode.sessionExpire){
       CommonFunctions.showSnackBar(title: "Alert", message: "Session Expired", type: PopupType.error);
       Get.offAll(()=> LogInScreen());
     }
    }

  }


  void checkForReferral(){
    String? referralCode=getCurrentUser?.referredBy;
    if(referralCode==null || referralCode==""){
      Get.bottomSheet(
        ReferalCoeSheet(),
        isDismissible: false,
      );
    }
  }


  Future<void> updateReferredBy()async{
    Map<String,dynamic> _dataToUpdate={
      'referredBy': referralCode.text!=""?referralCode.text:"Self"
    };

    String? curentUUid=await FirebaseService.getLoggedInUserUuId();

    if(curentUUid!=null){
      await FirebaseService.updateDocById(_dataToUpdate, curentUUid, FirebaseKeys.usersCollection);
      fetchimg();
    }

    isLoading.value=false;
  }
}