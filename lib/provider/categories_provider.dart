import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/category.dart';
import 'package:digiday_admin_panel/screens/categories/data/categories_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoriesProvider extends ChangeNotifier{
  final CategoriesRepository _categoriesRepository= CategoriesRepository();


  TextEditingController categoryTitle=TextEditingController();
  final addCategoryFormKey = GlobalKey<FormState>();
  String? selectedImage;

  void resetTextFields(){
    categoryTitle.clear();
    selectedImage;
  }


  bool isLoading=false;
  List<CategoryModel> categoriesList=<CategoryModel>[];
  List<CategoryModel> itemsToDisplay=<CategoryModel>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  final ImagePicker imagePicker = ImagePicker();

  void selectImages() async{
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image!=null){
     selectedImage=image.path;
     notifyListeners();
    }
  }

  Future<bool> addCategory() async{
    bool response=false;
    isLoading=true;
    try{
      String? imageResp=await _categoriesRepository.categoryPicUpload(selectedImage!);
      if(imageResp!=null){
        Map<String,dynamic> _categories = {
          'categoryName': categoryTitle.text,
          'categoryIcon': imageResp,
          'isFeatured': false,
        };

        response=await _categoriesRepository.addCategory(_categories)??false;

      }
      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {
      resetTextFields();
      isLoading = false;
    }
  }

 Future<bool> validateAndSubmit()async{
    bool result=false;
    if (addCategoryFormKey.currentState!.validate()) {
    try {
      result=
      await  addCategory();
    } catch (e) {
      print(e);
      rethrow;
    }
    }
    return result;
  }


///This works like init method
  categoriesProvider(){
    fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
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
    fetchCategoriesData();
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
              categoryType: data['categoryType']
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