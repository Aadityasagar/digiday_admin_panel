import 'dart:io';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/screens/login/data/account_repository.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AccountProvider extends ChangeNotifier {
  //Firebase Auth object
  late FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;
  Status get status => _status;

  String? get currentUserId => _auth.currentUser?.uid;

  final AccountRepository _accountRepository = AccountRepository();
  final ImagePicker profilePicPicker = ImagePicker();



  bool isLoading = false;
  String profilePicUrl="";
  UserData? _currentUser;
  UserData? get getCurrentUser => _currentUser;

  AccountProvider() {
    //initialise object
    _auth = FirebaseService.fireAuth;
    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);


    if(_status==Status.Authenticated){
      fetchProfileData();
    }
  }


  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
      fetchProfileData();
    }
    notifyListeners();
  }


  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await fetchProfileData();
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<void> fetchProfileData() async {
    try{
      UserData? userData=await _accountRepository.fetchProfileData();
      if(userData!=null){
        setCurrentUser=userData;
        fetchimg();
      }
      else{
        print("Users personal data not available");
      }
    }
    on ApiException catch(e){
      if(e.status==ApiExceptionCode.sessionExpire){
        CommonFunctions.showSnackBar(title: "Alert", message: "Session Expired", type: PopupType.error);
      }
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  set setCurrentUser(UserData? value) {
    _currentUser = value;
  }

  TextEditingController referralCode=TextEditingController();


  void selectProfilePic() async{
    isLoading=true;
    final XFile? selectedImage = await profilePicPicker.pickImage(source: ImageSource.gallery);
    if (selectedImage!=null){
      String? result = await _accountRepository.profilePicUpload(File(selectedImage.path));
      if(result!=null){
        updateProfileData(result);
      }
      else{
        isLoading=false;
      }
    }
  }



  void fetchimg()async{
    if(_currentUser?.photo!=null){
      profilePicUrl = await downloadURLExample("${ApiUrl.profilePicsFolder}/${_currentUser?.photo}");
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

    isLoading=false;
  }


  Future<String> downloadURLExample(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }





  void checkForReferral(){
    String? referralCode=getCurrentUser?.referredBy;
    if(referralCode==null || referralCode==""){
      // Get.bottomSheet(
      //   ReferalCoeSheet(),
      //   isDismissible: false,
      // );
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

    isLoading=false;
  }
}