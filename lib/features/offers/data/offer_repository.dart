// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hikesmoney/constants/app_urls.dart';
// import 'package:hikesmoney/constants/firebase_keys.dart';
// import 'package:hikesmoney/features/business/data/business_model.dart';
// import 'package:hikesmoney/features/offers/data/offer_model.dart';
// import 'package:hikesmoney/features/payouts/data/payout_model.dart';
// import 'package:hikesmoney/utils/services/network/firebase_service.dart';
// import 'package:hikesmoney/utils/shared_prefs/shared_prefrence_refs.dart';
//
// class PayoutRepository {
//   final preferenceRef = SharedPreferenceRef.instance;
//
//   Future<String?> offerPicUpload(String imagePath) async {
//     String uniqueFileName = "offer_banner_"+Timestamp.now().microsecondsSinceEpoch.toString();
//     String? response=await FirebaseService.uploadImageMethod( folder: ApiUrl.offerBannersFolder, fileToUpload: imagePath,uniqueFileName: uniqueFileName);
//       return response;
//   }
//
//   Future<bool?> addOffer(Map<String,dynamic> data)async{
//     try{
//       bool? result = await FirebaseService.addDocToCollection(collection: FirebaseKeys.offersCollection, docData: data);
//       return result;
//     }
//     on FirebaseAuthException catch (e) {
//       rethrow;
//     }
//   }
//
//
//   Future<bool?> updateOffer(String? offerId,Map<String,dynamic> data)async{
//     try{
//       bool?  offer = await FirebaseService.updateDocById(data, offerId!, FirebaseKeys.offersCollection);
//       return offer;
//     }
//     on FirebaseException catch (e) {
//       rethrow;
//     }
//   }
//
//
//   Future<BusinessData?> fetchOfferDeatails()async{
//     String? currentUid=FirebaseAuth.instance.currentUser?.uid;
//     if(currentUid!=null){
//       return await FirebaseService.fetchDocsByWhereClause(FirebaseKeys.ownerId, currentUid, FirebaseKeys.businessesCollection)
//           .then((QuerySnapshot? snapshot){
//         if (snapshot?.docs != null) {
//           QueryDocumentSnapshot<Object?>? businessData=snapshot?.docs.first;
//           if(businessData!=null){
//             BusinessData _business = BusinessData(
//               id: businessData.id,
//               businessName: businessData?['businessName'],
//               address: businessData?['address'],
//               phoneNumber: businessData?['phoneNumber'],
//               city: businessData?['city'],
//               state: businessData?['state'],
//               pinCode: businessData?['pinCode'],
//               banner: businessData?['banner'],
//               profilePicture: businessData?['profilePicture'],
//             );
//
//             return _business;
//           }
//         }
//         else{
//           debugPrint("Users has not added  any business");
//         }
//       });
//     }
//     else{
//       debugPrint("No user logged in");
//     }
//
//   }
//
//   Future<List<Payout>?> fetchPayouts(String businessId) async{
//    try{
//      return FirebaseService.fetchDocsByWhereClause(FirebaseKeys.businessId, businessId, FirebaseKeys.offersCollection)
//          .then((QuerySnapshot? snapshot){
//        if (snapshot != null) {
//          List<Payout> payoutsList=[];
//        for (var element in snapshot.docs) {
//          String? payoutId=element.id;
//          var offerData=element.data()  as Map<String,dynamic>;
//          payoutData['id']=payoutId;
//         Offer obj=Offer.fromJson(offerData);
//          payoutsList.add(obj);
//        }
//
//        if(payoutsList!=null){
//            return payoutsList;
//          }
//        }
//        else{
//          debugPrint("No payouts available");
//        }
//      });
//    }
//    on FirebaseException catch(e){
//     debugPrint(e.message);
//    }
//
//   }
// }