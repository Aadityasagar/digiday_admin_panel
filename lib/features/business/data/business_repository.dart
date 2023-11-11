import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/business/data/business_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class BusinessRepository {
  final preferenceRef = SharedPreferenceRef.instance;



  Future<void> updateBusinessData(String? userId,Map<String,dynamic> data)async{
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


  Future<bool?> addBusiness(Map<String,dynamic> data)async{
    try{
      DocumentReference?  business = await FirebaseFirestore.instance
          .collection('businesses')
          .add(data);
      return true;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<bool?> updateBusiness(String? businessId,Map<String,dynamic> data)async{
    try{
      bool?  business = await FirebaseService.updateDocById(data, businessId!, 'businesses');
      return business;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }


  Future<BusinessData?> fetchBusinessData()async{
    String? currentUid=FirebaseAuth.instance.currentUser?.uid;
    if(currentUid!=null){
     return await FirebaseService.fetchDocsByWhereClause(FirebaseKeys.ownerId, currentUid, FirebaseKeys.businessesCollection)
          .then((QuerySnapshot? snapshot){
        if (snapshot?.docs != null) {
          QueryDocumentSnapshot<Object?>? businessData=snapshot?.docs.first;
          if(businessData!=null){
            BusinessData _business = BusinessData(
              id: businessData.id,
              businessName: businessData?['businessName'],
              address: businessData?['address'],
              phoneNumber: businessData?['phoneNumber'],
              city: businessData?['city'],
              state: businessData?['state'],
              pinCode: businessData?['pinCode'],
              banner: businessData?['banner'],
              profilePicture: businessData?['profilePicture'],
            );

           return _business;
          }
        }
        else{
          debugPrint("Users has not added  any business");
        }
      });
    }
    else{
      debugPrint("No user logged in");
    }

  }


  Future<bool?> deleteOffer(String offerId)async{
    try {
      return await FirebaseService.deleteDocByDocID(
          docId: offerId, collection: FirebaseKeys.offersCollection);
    }on FirebaseAuthException catch (e) {
      rethrow;
    }

    }
}