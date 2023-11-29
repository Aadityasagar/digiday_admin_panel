import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/category.dart';
import 'package:digiday_admin_panel/screens/categories/data/categories_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider extends ChangeNotifier{
  final CategoriesRepository _categoriesRepository= CategoriesRepository();

  bool isLoading=false;
  List<CategoryModel> categoriesList=<CategoryModel>[];
  List<CategoryModel> itemsToDisplay=<CategoryModel>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  categoriesProvider(){
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _categoriesRepository.fetchCategoriesData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processCategoriesData(response);
      }
      else {
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  void nextPageData(){
    currentPage=currentPage+1;
    fetchCategoryData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }

  void processCategoriesData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {


            CategoryModel categoryData = CategoryModel(
              categoryName: data['categoryName'],
              categoryIcon: data['categoryIcon']
            );

            if(data?['categoryIcon']!=null){
              categoryData.categoryIcon = await fetchImageUrl("${ApiUrl.categoryPicFolder}/${data?['categoryIcon']}");
            }

            categoriesList.add(categoryData);
          }
        }

        lastDocument=snapshot.docs.last;
      }
    }on Exception catch(e){
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }

  }







}