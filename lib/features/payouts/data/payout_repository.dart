
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/payouts/data/payout_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PayoutRepository {
  final preferenceRef = SharedPreferenceRef.instance;



  Future<bool?> updateOffer(String? offerId,Map<String,dynamic> data)async{
    try{
      bool?  offer = await FirebaseService.updateDocById(data, offerId!, FirebaseKeys.offersCollection);
      return offer;
    }
    on FirebaseException catch (e) {
      rethrow;
    }
  }


  Future<List<Payout>?> fetchPayouts() async{
    try{
      return FirebaseService.fetchDocsByWhereClause( FirebaseKeys.payoutStatus,  "Pending",FirebaseKeys.payoutsCollection)
          .then((QuerySnapshot? snapshot)async{
        if (snapshot != null) {
          List<Payout> payoutsList=[];
          for (var element in snapshot.docs) {
            String? payoutId=element.id;
            var payoutData=element.data()  as Map<String,dynamic>;
            String walletId=payoutData['walletId'];


            Map<String,dynamic> userInfo={};

            await FirebaseService.fetchDocByDocID(collection: FirebaseKeys.usersCollection,docId: walletId)
                .then((DocumentSnapshot? snapshot){
              if (snapshot!=null) {
                Map<String, dynamic>? userData = snapshot.data() as Map<
                    String,
                    dynamic>?;
                if (userData != null) {
                  userInfo['name']=userData['firstName'];
                  userInfo['phone']=userData['phone'];
                }
              }
            });


            Map<String,dynamic> accountInfo={};

           await FirebaseService.fetchDocByDocID(collection: FirebaseKeys.usersBankAccountsCollection,docId: walletId)
                .then((DocumentSnapshot? snapshot){
              if (snapshot!=null) {
                Map<String, dynamic>? userData = snapshot.data() as Map<
                    String,
                    dynamic>?;
                if (userData != null) {
                  accountInfo['account_holder']=userData['account_holder'];
                  accountInfo['bank_name']=userData['bank_name'];
                  accountInfo['ifsc']=userData['ifsc'];
                  accountInfo['account_number']=userData['account_number'];
                }
              }
            });



            payoutData['id']=payoutId;
            payoutData['name']=userInfo['name'];
            payoutData['phone']=userInfo['phone'];
            payoutData['bank_name']=accountInfo['bank_name'];
            payoutData['ifsc']=accountInfo['ifsc'];
            payoutData['account_holder']=accountInfo['account_holder'];
            payoutData['account_number']=accountInfo['account_number'];
            payoutData['wallet']=walletId;
            Payout obj=Payout.fromJson(payoutData);
            payoutsList.add(obj);
          }

          if(payoutsList!=null){
            return payoutsList;
          }
        }
        else{
          debugPrint("No payouts available");
        }
      });
    }
    on FirebaseException catch(e){
      debugPrint(e.message);
    }

  }
}