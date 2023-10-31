import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/account/data/models/subscription_model.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/common/data/api_response.dart';
import 'package:digiday_admin_panel/features/subscriptions/data/model/vendor_plan_model.dart';
import 'package:digiday_admin_panel/utils/services/network/api_base_helper.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SubscriptionRepository {
  final ApiBaseHelper _apiBaseHelper = Get.find<ApiBaseHelper>();
  final AppSessionController _appSessionController = Get.find<AppSessionController>();

  /// This method fetches all vendor plans available
  Future<List<VendorPlan>?> fetchTeamPlans() async {
   try{
     List<VendorPlan>? plans=<VendorPlan>[];

     await FirebaseService.fetchDocs(FirebaseKeys.teamPlansCollection)
         .then((QuerySnapshot? snapshot) {

       snapshot?.docs.forEach((doc) {
         plans.add(VendorPlan(
             id: doc.id,
             planName: doc['name'],
             planPrice: doc['rate'],
             planValidity: doc['validityInDays']
         ));
       });
     });

     return plans;
   }on FirebaseException catch(e){
     rethrow;
   }
  }



  Future<Map<String,dynamic>?> fetchSubscriptionStatusPendingPayment() async {
    ApiResponse? response = await _apiBaseHelper.get(
        endPoint: ApiUrl.kVendorSubscriptionStatus);

    if (response?.code == 200) {
      return response?.data;
    } else {
      throw ApiException(message: response?.message);
    }
  }


  // Future<void> updateSub(String newPlanId) async{
  //   String? currentUid=await _appSessionController.getLoggedInUsersUid();
  //   if(currentUid!=null) {
  //
  //     int newValidity=0;
  //
  //     FirebaseService.fetchDocByDocID(docId: newPlanId, collection: FirebaseKeys.vendorPlansCollection)
  //         .then((DocumentSnapshot? documentSnapshot){
  //       Map<String,dynamic>? planData=documentSnapshot?.data() as Map<String,dynamic>?;
  //       newValidity=planData?['validityInDays'];
  //     });
  //
  //
  //     String? currentPlan = newPlanId;
  //     String lastRechargeDate= DateTime.now().microsecondsSinceEpoch.toString();
  //     String nextRechargeDate =DateTime.now().add(Duration(days: newValidity)).microsecondsSinceEpoch.toString();
  //     String? status="Active";
  //
  //     FirebaseFirestore.instance
  //         .collection('vendorSubscriptions')
  //         .doc(currentUid)
  //         .set({
  //       'currentPlan': currentPlan,
  //       'lastRechargeDate': lastRechargeDate,
  //       'nextRechargeDate': nextRechargeDate,
  //       'status': status
  //     });
  //   }
  // }


  // Future<void> updateSubOrder(String orderId,String subId,String status)async{
  //   try{
  //
  //     Map<String,dynamic> dataToUpdate={'status': status};
  //     await FirebaseService.updateDocById(dataToUpdate, orderId, FirebaseKeys.vendorSubscriptionOrdersCollection).then((_) async{
  //       // Data saved successfully!
  //       if(status=="Completed"){
  //         await updateSub(subId);
  //       }
  //     }).catchError((error) {
  //       // The write failed...
  //
  //     });
  //   }
  //   on FirebaseException catch (e) {
  //     rethrow;
  //   }
  // }

  Future<String?> purchasePlan(String planId,String amount) async {

    String? uuid=await _appSessionController.getLoggedInUsersUid();

    Map<String, dynamic> _body = {
      'planId': planId,
      'orderTotal': amount,
      'subscriptionType': "Team",
      'desc': "Team plan purchase.",
      'pg':"Paytm",
      'status':"Pending",
      'userId': uuid
    };

     try{
         DocumentReference?  order = await FirebaseFirestore.instance.collection('subscriptionOrders').add(_body);
         return order.id;
     }
     on FirebaseException catch(e){
      debugPrint(e.message);
     }
  }


  Future<SubscriptionData?> fetchSubscriptionData() async{
    String? currentUid=await FirebaseService.getLoggedInUserUuId();
    if(currentUid!=null){
    return await FirebaseService.fetchDocByDocID(docId: currentUid, collection: FirebaseKeys.teamSubscriptionsCollection).then((DocumentSnapshot? documentSnapshot) async{
        if (documentSnapshot!=null) {
          Map<String,dynamic>? subData=documentSnapshot.data() as Map<String,dynamic>?;
          if(subData!=null){
            String? currentPlanId=subData?[FirebaseKeys.currentPlan];

          return await FirebaseService.fetchDocByDocID(docId: currentPlanId!, collection: FirebaseKeys.teamPlansCollection)
                .then((DocumentSnapshot? planSnapshot) async{

              Map<String,dynamic>? planData=planSnapshot?.data() as Map<String,dynamic>?;

              SubscriptionData _sub=SubscriptionData(
                vendorId: subData?['vendorId'],
                currentPlanName: planData?['name'],
                currentPlanRate: planData?['rate'].toString(),
                currentPlanValidity: planData?['validityInDays'].toString(),
                nextRechargeDate: DateTime.fromMillisecondsSinceEpoch(subData?['nextRechargeDate']),
                lastRechargeDate: DateTime.fromMillisecondsSinceEpoch(subData?['lastRechargeDate']),
                status: subData?['status'],
              );

               return _sub;
            });

          }
        }
      });
    }
    else{
      debugPrint("No user logged in");
    }
  }


  Future<void> upDateStatus(String order,String plan,
      String status,
      int planValidity
      ) async{
try {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    'updateOrderTeam',
    options: HttpsCallableOptions(
      timeout: const Duration(seconds: 15),
    ),
  );

  String? currentUid = await FirebaseService.getLoggedInUserUuId();

  await callable.call(<String, dynamic>{
    'status': status,
    'orderId': order,
    'planId': plan,
    'currentUid': currentUid,
    'planValidity': planValidity
  }).then(
          (value) => {
  });
   } on FirebaseException catch (e) {
     rethrow;
    }
  }



  Future<Map<String,dynamic>?> fetchParentId(String code) async {
    try {
      return FirebaseService.fetchDocsByWhereClause(
          FirebaseKeys.referralCode, code, FirebaseKeys.usersCollection)
          .then((QuerySnapshot? snapshot) async {
        if (snapshot != null) {
          var userData = snapshot.docs.first;
          if (userData != null) {
            return {
              'id': userData.id,
              'referredBy': userData['referredBy']
            };
          }
        }
      });
    } on FirebaseService catch (e) {
      rethrow;
    }
  }


  }