import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/screens/product/data/products_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ProductsProvider extends ChangeNotifier{
  final ProductsRepository _productsRepository= ProductsRepository();

  bool isLoading=false;
  List<Product> productsList=<Product>[];
  List<Product> itemsToDisplay=<Product>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  ProductsProvider(){
    fetchProductData();
  }


  Future<void> fetchProductData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _productsRepository.fetchProductsData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processProductData(response);
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
    fetchProductData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }

  void processProductData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {

            Product productData = Product(
              id: data['businessId'],
              productTitle: data['productTitle'],
              productBrand: data['productBrand'],
              productCategory: data['productCategory'],
              productDescription: data['productDescription'],
              productImage: data['productImage'],
              productImageGallery: data['productImageGallery'],
              productRegularPrice: data['productSalePrice'],
              productSalePrice: data['productRegularPrice']

            );




            if(data?['productImage']!=null){
              productData.productImage = await fetchImageUrl("${ApiUrl.productPicFolder}/${data?['productImage']}");
            }

            productsList.add(productData);
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