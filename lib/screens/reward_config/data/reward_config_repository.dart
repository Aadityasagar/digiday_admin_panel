import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RewardConfigRepository{
  Future<QuerySnapshot?> fetchRewardsConfigData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsWithPagination(
          collection: FirebaseKeys.rewardsConfig,
          limitCount: limitPerPage,
          lastDocument: lastDocument);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }

  Future<bool?> editRewardConfig(Map<String,dynamic> data,String rewardConfigId)async{
    try{
      bool? result = await FirebaseService.updateDocById(data,rewardConfigId,FirebaseKeys.rewardsConfig);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }
}