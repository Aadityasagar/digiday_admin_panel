import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/category.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';

class CategoriesRepository{
  List<CategoryModel> categoriesList = [];

  Future<QuerySnapshot?> fetchCategoriesData({int? page,int? limitPerPage,DocumentSnapshot? lastDocument}) async {
    try {
      late QuerySnapshot? snapshot;

      snapshot = await FirebaseService.fetchDocsWithPagination(
          collection: FirebaseKeys.categoriesCollection,
          limitCount: limitPerPage,
          lastDocument: lastDocument);

      return snapshot;

    }
    on FirebaseService catch (e){
      rethrow;
    }

  }
}