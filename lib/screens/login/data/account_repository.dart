import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class AccountRepository {
  Future updatePersonalDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String address,
    required String city,
    required String state,
    required String pincode
  }) async {

    final Map<String, dynamic> _body = {
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "phone":phone,
      "address":address,
      "city":city,
      "state":state,
      "pinCode":pincode
    };

   try{
     String? uuid=await FirebaseService.getLoggedInUserUuId();
     if(uuid!=null) {
       await FirebaseService.updateDocById(
           _body, uuid!, FirebaseKeys.usersCollection);
     }
   }
   on FirebaseService catch(e){
     rethrow;
   }on ApiException catch(e){
     rethrow;
   }

  }

  //To upload profile pic
  Future<String?> profilePicUpload(File imgFile) async {
    String uniqueFileName = "profile_pic_"+Timestamp.now().microsecondsSinceEpoch.toString();
   String? response=await  FirebaseService.uploadImageMethod( folder: ApiUrl.profilePicsFolder, fileToUpload: imgFile.path,uniqueFileName: uniqueFileName);
    if (response!=null) {
      return response;
    }
  }


  Future<UserData?> fetchProfileData() async{
    try{
      String? currentUid=await FirebaseService.getLoggedInUserUuId();
      if(currentUid!=null){
      return  FirebaseService.fetchDocByDocID(docId: currentUid, collection: FirebaseKeys.usersCollection)
            .then((DocumentSnapshot? documentSnapshot) async {
          if (documentSnapshot!=null) {
            Map<String,dynamic>? userData=documentSnapshot.data() as Map<String,dynamic>?;

            if(userData!=null){

              UserData _user = UserData(
                firstName: userData?['firstName'],
                lastName: userData?['lastName'],
                email: userData?['email'],
                phone: userData?['phone'],
                isVendor: userData?['isVendor'],
                referredBy: userData?['referredBy'],
                  referralCode: userData?['referralCode'],
                photo: userData?['photo'],
                address: userData?['address'],
                city: userData?['city'],
                state: userData?['state'],
                pinCode: userData?['pinCode'],
                phoneVerified: userData?['phoneVerified'],
                emailVerified: userData?['emailVerified']
              );

              return _user;
            }

          }
        });
      }
    }on FirebaseService catch(e){
      rethrow;
    }

  }




}
