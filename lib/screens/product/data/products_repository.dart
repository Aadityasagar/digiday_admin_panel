import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsRepository{
  List<Product> productsList = [];

  Future<QuerySnapshot?> fetchAllProductsData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereClause(
        filterKey: FirebaseKeys.status,
          filterValue: "Not Verified",
          collection: FirebaseKeys.productsCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }

  Future<QuerySnapshot?> fetchApprovedProductsData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereClause(
          filterKey: FirebaseKeys.status,
          filterValue: "Verified",
          collection: FirebaseKeys.productsCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }


  Future<QuerySnapshot?> fetchRejectedProductsData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsByWhereClause(
          filterKey: FirebaseKeys.status,
          filterValue: "Rejected",
          collection: FirebaseKeys.productsCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }

  Future<bool?> verifyProduct(Map<String,dynamic> data,String productId)async{
    try{
      bool? result = await FirebaseService.updateDocById(data, productId, FirebaseKeys.productsCollection);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<bool?> rejectProduct(Map<String,dynamic> data,String productId)async{
    try{
      bool? result = await FirebaseService.updateDocById(data, productId, FirebaseKeys.productsCollection);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<bool?> productRejectionReason(Map<String,dynamic> data)async{
    try{
      bool? result = await FirebaseService.addDocToCollection(collection: FirebaseKeys.rejectedProductsCollection, docData: data);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }


}