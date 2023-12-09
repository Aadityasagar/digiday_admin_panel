import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/models/category.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoriesRepository{
  List<CategoryModel> categoriesList = [];

  Future<String?> categoryPicUpload(String imagePath) async {
    try {
      String uniqueFileName = "category_pic_${Timestamp.now().microsecondsSinceEpoch}";
      String? response=await FirebaseService.uploadImageMethod( folder: ApiUrl.categoryPicFolder, fileToUpload: imagePath,uniqueFileName: uniqueFileName);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> addCategory(Map<String,dynamic> data)async{
    try{
      bool? result = await FirebaseService.addDocToCollection(collection: FirebaseKeys.categoriesCollection, docData: data);
      return result;
    }
    on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

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