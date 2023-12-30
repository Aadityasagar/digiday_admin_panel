import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class CmRepository {
  Future<QuerySnapshot?> fetchActiveCmTeamData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereAndWhereClause(
          filterKey: FirebaseKeys.userSubscriptionStatus,
          filterValue: "active",
          filterKeySecond: FirebaseKeys.isCm,
          filterValueSecond: true,
          collection: FirebaseKeys.usersCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument

      );

      return snapshot;

  }
  on FirebaseService catch (e){
  rethrow;
  }

}

  Future<QuerySnapshot?> fetchInactiveCmTeamData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereAndWhereClause(
          filterKey: FirebaseKeys.userSubscriptionStatus,
          filterValue: "inactive",
          filterKeySecond: FirebaseKeys.isCm,
          filterValueSecond: true,
          collection: FirebaseKeys.usersCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument

      );

      return snapshot;

  }
  on FirebaseService catch (e){
  rethrow;
  }

}

  Future<String?> fetchCmWalletBalance(String? cmId) async{
    try{
      if(cmId!=null){
        return  FirebaseService.fetchDocByDocID(docId: cmId, collection: FirebaseKeys.walletsCollection)
            .then((DocumentSnapshot? documentSnapshot) async {
          if (documentSnapshot?.data() !=null) {
            Map<String,dynamic>? userData=documentSnapshot?.data() as Map<String,dynamic>?;

            if(userData!=null){
              String? _walletbalance = userData?['balance'];
              return _walletbalance;
            }

          }
          else{
            return "0.0";
          }
        });
      }
    }on FirebaseService catch(e){
      rethrow;
    }

  }


}