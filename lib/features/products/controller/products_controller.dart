import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/products/add_products.dart';
import 'package:digiday_admin_panel/features/products/data/product_repository.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/product_model.dart';

class ProductController extends GetxController{
  RxBool isLoading = false.obs;
  final ProductRepository _productRepository = ProductRepository();

  TextEditingController productTitle=TextEditingController();
  TextEditingController productDescription=TextEditingController();
  TextEditingController productBrand=TextEditingController();
  TextEditingController productCategory=TextEditingController();
  TextEditingController productRegularPrice = TextEditingController();
  TextEditingController productSalePrice = TextEditingController();

  GlobalKey<ScaffoldState> productsScaffoldKey = GlobalKey<ScaffoldState>();




  RxString? selectedImage="".obs;

  RxList<Product> products=<Product>[].obs;

  Product? selectedProduct;


  final ImagePicker imagePicker = ImagePicker();

  void selectImages() async{
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image!=null){
     selectedImage?.value=image.path;
    }
  }


  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }



  void resetTextFields(){
   productTitle.clear();
   productDescription.clear();
   productRegularPrice.clear();
   productSalePrice.clear();
   selectedImage?.value="";
  }


  void navigateToEditScreen(Product product){
    selectedProduct=product;
    resetTextFields();
    loadTextFields();
    Get.back();
  }

  void loadTextFields(){
    productTitle.text=selectedProduct?.productTitle??"";
    productDescription.text=selectedProduct?.productDescription??"";
    productRegularPrice.text =selectedProduct?.productRegularPrice??"";
    productSalePrice.text =selectedProduct?.productSalePrice??"";
  }


  Future<void> addProduct(String businessId) async{
    isLoading.value=true;
    try{
      String? imageResp=await _productRepository.productPicUpload(selectedImage!.value!);
      if(imageResp!=null){

       Map<String,dynamic> _offerData = {
         'businessId': businessId,
         'productTitle': productTitle.text,
         'productDescription': productDescription.text,
         'productRegularPrice': productRegularPrice.text,
         'productSalePrice': productSalePrice.text,
         'productImage': imageResp,
         'productImageGallery': imageResp,
       };

       bool? response=await _productRepository.addProduct(_offerData);
       if(response==true){
         //fetchOffers(businessId);
        // Get.off(()=> OffersScreen());
       }
     }
     else{
       debugPrint("image not uploaded");
     }
    }on FirebaseException catch(e){
      debugPrint(e.message);
    }finally {
      resetTextFields();
      isLoading.value = false;
    }
  }



  // Future<void> editOffer(String businessId) async{
  //   isLoading.value=true;
  //   try{
  //
  //       if(selectedImage?.value!="" && selectedImage?.value!=null){
  //         String? imageResp=await _offerRepository.offerPicUpload(selectedImage!.value!);
  //         if(imageResp!=null){
  //
  //           Map<String,dynamic> _offerData = {
  //             'businessId': businessId,
  //             'offerTitle': offerTitle.text,
  //             'description': description.text,
  //             'offerType': offerType.text,
  //             'discountAmount': discountAmount.text,
  //             'offerCode': offerCode.text,
  //             'offerBanner': imageResp
  //           };
  //
  //           bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
  //           if(response==true){
  //             fetchOffers(businessId);
  //             Get.off(()=> OffersScreen());
  //           }
  //       }
  //       }
  //       else if(selectedOffer!=null && selectedOffer!=""){
  //         Map<String,dynamic> _offerData = {
  //           'businessId': businessId,
  //           'offerTitle': offerTitle.text,
  //           'description': description.text,
  //           'offerType': offerType.text,
  //           'discountAmount': discountAmount.text,
  //           'offerCode': offerCode.text
  //         };
  //
  //         bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
  //         if(response==true){
  //           fetchOffers(businessId);
  //           Get.off(()=> OffersScreen());
  //         }
  //       }
  //
  //
  //   }on FirebaseException catch(e){
  //     debugPrint(e.message);
  //   }finally {
  //     resetTextFields();
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> deleteBusinessOffer(String offerId) async{
  //   isLoading.value=true;
  //   try{
  //     bool? result= await _businessRepository.deleteOffer(offerId);
  //     if(result!=null && result){
  //       offers.removeWhere((element) => element.id==offerId);
  //     }
  //   }on FirebaseException catch(e){
  //     debugPrint(e.message);
  //   }finally {
  //      Get.back();
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> fetchOffers(String?  businessId) async{
  //   isLoading.value=true;
  //   try{
  //     List<Product>? response = await _offerRepository.fetchOffers(businessId!);
  //     if(response!=null){
  //      // setBusinessData=response;
  //       offers.clear();
  //       offers.addAll(response);
  //
  //       for (var offer in offers) {
  //         offer.offerBanner = await fetchImgUrl(offer.offerBanner!);
  //       }
  //     }
  //     else{
  //       Get.to(()=>AddBusiness());
  //     }
  //   }on FirebaseException catch(e){
  //     debugPrint(e.message);
  //   }finally {
  //     offers.refresh();
  //     isLoading.value = false;
  //   }
  // }
  //
  // String? cityFieldValidator(String? value) {
  //   String? errorMsg;
  //   if (value==null || value=="") {
  //     errorMsg="City can't be empty";
  //   } else if (CitiesService.cities.contains(value)==false) {
  //     errorMsg="City is not valid kindly select from list.";
  //   }
  //   return errorMsg;
  // }
  //
  // List<String> offerTypes=["Percentage Discount","Flat Discount","Free Item"];
  //
  // String? offerTypeValidator(String? value) {
  //   String? errorMsg;
  //   if (value==null || value=="") {
  //     errorMsg="Type can't be empty";
  //   } else if (offerTypes.contains(value)==false) {
  //     errorMsg="Offer type is not valid kindly select from list.";
  //   }
  //   return errorMsg;
  // }


  void validateAndSubmit(String businessId){
    // if (addOfferFormKey.currentState!.validate()) {
    //   addOffer(businessId);
    // }
  }

  void validateAndUpdate(String business){
    // if (updateOfferFormKey.currentState!.validate()) {
    //   editOffer(business??"");
    // }
  }

  Future<void> fetchProducts() async{
    isLoading.value=true;
    try{
      List<Product>? response = await _productRepository.fetchProducts();
      if(response!=null){
        products.addAll(response);
      }
      else{
        Get.to(()=>AddProduct());
      }
    }on FirebaseException catch(e){
      debugPrint(e.message);
    }finally {
      products.refresh();
      isLoading.value = false;
    }
  }


  Future<String?> fetchImgUrl(String photo)async {
    try{
      String? url = await FirebaseService.getImageUrl(photo);
      debugPrint("$url");
      return url;
    }on Exception catch (e){
      debugPrint(e.toString());
    }
  }

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));




  @override
  void onClose() {
    // Close resources and cleanup
    super.onClose();
  }
}