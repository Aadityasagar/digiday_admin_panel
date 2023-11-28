import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class VendorRepository {
  List<UserData> vendorMates = [];

  Future<QuerySnapshot?> fetchVendorsData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereClause(
          filterKey: FirebaseKeys.isVendor,
          filterValue: true,
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

}