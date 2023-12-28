import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/screens/product/data/products_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier{
  final ProductsRepository _productsRepository= ProductsRepository();
  final CarouselController carouselController = CarouselController();


  TextEditingController rejectionReason=TextEditingController();
  final rejectionReasonFormKey = GlobalKey<FormState>();

  final List<Tab> pageTabs = <Tab>[
    const Tab(text: 'Products'),
    const Tab(text: 'Approved Products'),
    const Tab(text: 'Rejected Products'),
  ];


  bool isLoading=false;
  List<Product> allProductsList=<Product>[];
  List<Product> approvedProductsList=<Product>[];
  List<Product> rejectedProductsList=<Product>[];
  List<Product> itemsToDisplay=<Product>[];
  DocumentSnapshot<Object?>? lastDocument;
  int currentPage=1;
  int itemsPerPageLimit=100;
  int totalItems=10;

  Product? selectedProduct;

  ProductsProvider(){
    fetchAllProductData();
    fetchApprovedProductData();
    fetchRejectedProductData();
  }


  Future<void> fetchAllProductData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _productsRepository.fetchAllProductsData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processAllProductData(response);
      }
      else {
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchApprovedProductData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _productsRepository.fetchApprovedProductsData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processApprovedProductData(response);
      }
      else {
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchRejectedProductData() async {
    isLoading = true;
    try {
      QuerySnapshot? response = await _productsRepository.fetchRejectedProductsData(
          limitPerPage: itemsPerPageLimit,
          lastDocument: lastDocument
      );
      if (response!= null) {
        processRejectedProductData(response);
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
    fetchAllProductData();
  }

  Future<String> fetchImageUrl(String img) async {
    String downloadURL = await FirebaseStorage.instance
        .ref()
        .child(img)
        .getDownloadURL();

    return downloadURL;
  }

  void processAllProductData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          String productId=element.id;
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {

            Product productData = Product(
              id: productId,
              productTitle: data['productTitle'],
              businessId: data['businessId'],
              productBrand: data['productBrand'],
              productCategory: data['productCategory'],
              productDescription: data['productDescription'],
              productImage: data['productImage'],
              productRegularPrice: data['productRegularPrice'],
              productSalePrice: data['productSalePrice'],
              status: data['status']

            );

            if(data['productImage']!=null){
              productData.productImage = await fetchImageUrl("${ApiUrl.productPicFolder}/${data?['productImage']}");
            }

            allProductsList.add(productData);
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

  void processApprovedProductData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          String productId=element.id;
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {

            Product productData = Product(
                id: productId,
                productTitle: data['productTitle'],
                businessId: data['businessId'],
                productBrand: data['productBrand'],
                productCategory: data['productCategory'],
                productDescription: data['productDescription'],
                productImage: data['productImage'],
                productRegularPrice: data['productRegularPrice'],
                productSalePrice: data['productSalePrice'],
              status: data['status']

            );

            if(data['productImage']!=null){
              productData.productImage = await fetchImageUrl("${ApiUrl.productPicFolder}/${data?['productImage']}");
            }

            approvedProductsList.add(productData);
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

  void processRejectedProductData(QuerySnapshot snapshot)async{

    try{
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          String productId=element.id;
          var data = element.data() as Map<String, dynamic>;
          if (data != null) {

            Product productData = Product(
                id: productId,
                productTitle: data['productTitle'],
                businessId: data['businessId'],
                productBrand: data['productBrand'],
                productCategory: data['productCategory'],
                productDescription: data['productDescription'],
                productImage: data['productImage'],
                productRegularPrice: data['productRegularPrice'],
                productSalePrice: data['productSalePrice'],
              status: data['status']

            );

            if(data['productImage']!=null){
              productData.productImage = await fetchImageUrl("${ApiUrl.productPicFolder}/${data?['productImage']}");
            }

            rejectedProductsList.add(productData);
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


  Future<bool> verifyProduct(String productId,String value) async{
    isLoading=true;
    notifyListeners();
    try{

      Map<String,dynamic> _productData = {
        'status': value
      };

     bool response= await _productsRepository.verifyProduct(_productData,productId)??false;
      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {
      fetchAllProductData();
      nextPageData();
    }
  }

  Future<bool> rejectProduct(String productId,String value) async{
    isLoading=true;
    notifyListeners();
    try{

      Map<String,dynamic> _productData = {
        'status': value
      };

      bool response= await _productsRepository.rejectProduct(_productData,productId)??false;
      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {
      fetchAllProductData();
      notifyListeners();
    }
  }


  Future<bool> productRejectionReason(String productId) async{
    bool response=false;
    isLoading=true;
    notifyListeners();
    try{

      Timestamp serverTimestamp = Timestamp.now();
      DateTime rejectedAt = serverTimestamp.toDate();

      Map<String,dynamic> _rejectionData = {
        'productId': productId,
        'reason': rejectionReason.text,
        'rejectedAt': rejectedAt.millisecondsSinceEpoch,
      };

      response=await _productsRepository.productRejectionReason(_rejectionData)??false;

      return response;

    }on FirebaseException catch(e){
      debugPrint(e.message);
      rethrow;
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> validateAndSubmitReason(String productId)async{
    bool result=false;
    if (rejectionReasonFormKey.currentState!.validate()) {
      try {
        result= await productRejectionReason(productId);
      } catch (e) {
        print(e);
        rethrow;
      }
    }
    return result;
  }




}