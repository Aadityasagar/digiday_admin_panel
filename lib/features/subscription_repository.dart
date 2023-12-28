import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/subscription_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class SubscriptionRepository{
  List<SubscriptionData> subscribersList = [];

  Future<QuerySnapshot?> fetchSubscriptionData() async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocs(FirebaseKeys.teamSubscriptionsCollection);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
}