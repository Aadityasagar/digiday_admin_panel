import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/category.dart';
import 'package:digiday_admin_panel/screens/categories/data/categories_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_image_picker_web/image_picker_web.dart';

class CategoriesProvider extends ChangeNotifier{
  final CategoriesRepository _categoriesRepository= CategoriesRepository();
  TextEditingController categoryTitle=TextEditingController();
  final addCategoryFormKey = GlobalKey<FormState>();
  final editCategoryFormKey = GlobalKey<FormState>();
  Uint8List? selectedImage;

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

  CategoryModel? selectedCategory;


  void selectCategoryToEdit(CategoryModel categoryToEdit){
    selectedCategory=categoryToEdit;
    categoryTitle.text=categoryToEdit.categoryName??"";
  }

  void selectImages() async{
    //final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List? image = await ImagePickerWeb.getImageAsBytes();
    if (image!=null){
     selectedImage=image;
     notifyListeners();
    }
  }

  Future<bool> addCategory() async{
    bool response=false;
    isLoading=true;
    notifyListeners();
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
      notifyListeners();
    }
  }

  Future<bool> editCategory() async{
    bool response=false;
    isLoading=true;
    notifyListeners();
    try{
      String? imageResp;

      if(selectedImage!=null){
        imageResp=await _categoriesRepository.categoryPicUpload(selectedImage!);
      }



      Map<String,dynamic> _categories = imageResp!=null ? {
        'categoryName': categoryTitle.text,
        'categoryIcon': imageResp
      }: {
        'categoryName': categoryTitle.text
      };

      response=await _categoriesRepository.editCategory(_categories,selectedCategory!.id!)??false;
      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {

      selectedImage!.clear();
      selectedCategory=null;
      resetTextFields();
      isLoading=false;
      fetchCategoriesData();
    }
  }

  Future<bool> makeCategoryFeatured(String categoryId,bool value) async{
    bool response=false;
    isLoading=true;
    notifyListeners();
    try{

      Map<String,dynamic> _categorieData = {
        'isFeatured': value
      };

      response=await _categoriesRepository.makeCategoryFeatured(_categorieData,categoryId)??false;
      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {
      fetchCategoriesData();
    }
  }

 Future<bool> validateAndSubmit()async{
    bool result=false;
    if (addCategoryFormKey.currentState!.validate()) {
    try {
      result= await addCategory();
    } catch (e) {
      print(e);
      rethrow;
    }
    }
    return result;
  }



 Future<bool> validateAndEdit()async{
    bool result=false;
    if (editCategoryFormKey.currentState!.validate()) {
    try {
      result= await editCategory();
    } catch (e) {
      print(e);
      rethrow;
    }
    }
    return result;
  }


///This works like init method
  CategoriesProvider(){
    fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
    categoriesList.clear();
    isLoading = true;

    notifyListeners();

    try {
      QuerySnapshot? response = await _categoriesRepository.fetchCategoriesData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );

      if (response!= null) {
        processCategoriesData(response);
      } else {

      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void nextPageData(){
    currentPage=currentPage+1;
    fetchCategoriesData();
  }

  Future<String> fetchImageUrl(String img) async {
    String result="not-found";
    try {
      String downloadURL = await FirebaseStorage.instance
              .ref()
              .child(img)
              .getDownloadURL();

      result= downloadURL;
    } catch (e) {
      print(e);
    } finally {}

    return result;
  }

  void processCategoriesData(QuerySnapshot snapshot)async{
    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {


            CategoryModel categoryData = CategoryModel(
              categoryName: data['categoryName'],
              categoryIcon: data['categoryIcon'],
              isFeatured: data['isFeatured']
            );

            if(data?['categoryIcon']!=null){
              categoryData.id=element.id;
              categoryData.categoryIcon = await fetchImageUrl("${ApiUrl.categoryPicFolder}/${data?['categoryIcon']}");
            }

            categoriesList.add(categoryData);
          }
        }

        //lastDocument=snapshot.docs.last;
      }
    }on Exception catch(e){
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }

  }




}