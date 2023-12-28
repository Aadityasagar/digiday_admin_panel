import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class SubscribersRepository{


  Future<DocumentSnapshot?> fetchVendorSubscriptionData({int? page,int? limitPerPage,
    DocumentSnapshot? lastDocument, required String userId}) async {
    try {
      late DocumentSnapshot? snapshot;
      snapshot = await FirebaseService.fetchDocByDocID(docId: userId,collection: FirebaseKeys.vendorSubscription);
      return snapshot;
    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
  Future<DocumentSnapshot?> fetchCmSubscriptionData({int? page,int? limitPerPage,
    DocumentSnapshot? lastDocument, required String userId}) async {
    try {
      late DocumentSnapshot? snapshot;
      snapshot = await FirebaseService.fetchDocByDocID(docId: userId,collection: FirebaseKeys.teamSubscriptionsCollection);
      return snapshot;
    }
    on FirebaseService catch (e){
      rethrow;
    }

  }

  Future<DocumentSnapshot?> fetchVendorPlanDetails({int? page,int? limitPerPage,
    DocumentSnapshot? lastDocument, required String planId}) async {
    try {
      late DocumentSnapshot? snapshot;
      snapshot = await FirebaseService.fetchDocByDocID(docId: planId,collection: FirebaseKeys.vendorPlansCollection);
      return snapshot;
    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
  Future<DocumentSnapshot?> fetchCmPlanDetails({int? page,int? limitPerPage,
    DocumentSnapshot? lastDocument, required String planId}) async {
    try {
      late DocumentSnapshot? snapshot;
      snapshot = await FirebaseService.fetchDocByDocID(docId: planId,collection: FirebaseKeys.teamPlansCollection);
      return snapshot;
    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
}


