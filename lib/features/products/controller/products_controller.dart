// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hikesmoney/features/business/add_business.dart';
// import 'package:hikesmoney/features/business/data/business_repository.dart';
// import 'package:hikesmoney/features/offers/edit_offer.dart';
// import 'package:hikesmoney/features/offers/offers_screen.dart';
// import 'package:hikesmoney/features/products/data/product_repository.dart';
// import 'package:hikesmoney/utils/services/city_service.dart';
// import 'package:hikesmoney/utils/services/network/firebase_service.dart';
// import 'package:image_picker/image_picker.dart';
// import '../data/product_model.dart';
//
// class ProductController extends GetxController{
//   RxBool isLoading = false.obs;
//   final BusinessRepository _businessRepository = BusinessRepository();
//   final ProductRepository _productRepository = ProductRepository();
//
//   TextEditingController productTitle=TextEditingController();
//   TextEditingController productDescription=TextEditingController();
//   TextEditingController productType=TextEditingController();
//   TextEditingController productRegularPrice = TextEditingController();
//   TextEditingController productSalePrice = TextEditingController();
//
//
//
//   final addOfferFormKey = GlobalKey<FormState>();
//   final updateOfferFormKey = GlobalKey<FormState>();
//
//
//
//
//   RxString? selectedImage="".obs;
//
//   RxList<Product> product=<Product>[].obs;
//
//   Product? selectedProduct;
//
//
//   final ImagePicker imagePicker = ImagePicker();
//
//   void selectImages() async{
//     final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (image!=null){
//      selectedImage?.value=image.path;
//     }
//   }
//
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//
//
//   void resetTextFields(){
//    productTitle.clear();
//    productDescription.clear();
//    productType.clear();
//    productRegularPrice.clear();
//    productSalePrice.clear();
//    selectedImage?.value="";
//   }
//
//
//   void navigateToEditScreen(Product product){
//     selectedProduct=product;
//     resetTextFields();
//     loadTextFields();
//     Get.back();
//     Get.to(()=> const EditOffer());
//   }
//
//   void loadTextFields(){
//     productTitle.text=selectedProduct?.productTitle??"";
//     productDescription.text=selectedProduct?.productDescription??"";
//     productType.text =selectedProduct?.productType??"";
//     productRegularPrice.text =selectedProduct?.productRegularPrice??"";
//     productSalePrice.text =selectedProduct?.productSalePrice??"";
//   }
//
//
//   Future<void> addProduct(String businessId) async{
//     isLoading.value=true;
//     try{
//       String? imageResp=await _productRepository.productPicUpload(selectedImage!.value!);
//       if(imageResp!=null){
//
//        Map<String,dynamic> _offerData = {
//          'businessId': businessId,
//          'productTitle': productTitle.text,
//          'productDescription': productDescription.text,
//          'productType': productType.text,
//          'productRegularPrice': productRegularPrice.text,
//          'productSalePrice': productSalePrice.text,
//          'productImage': imageResp,
//          'productImageGallery': imageResp,
//        };
//
//        bool? response=await _productRepository.addProduct(_offerData);
//        if(response==true){
//          //fetchOffers(businessId);
//          Get.off(()=> OffersScreen());
//        }
//      }
//      else{
//        debugPrint("image not uploaded");
//      }
//     }on FirebaseException catch(e){
//       debugPrint(e.message);
//     }finally {
//       resetTextFields();
//       isLoading.value = false;
//     }
//   }
//
//
//
//   // Future<void> editOffer(String businessId) async{
//   //   isLoading.value=true;
//   //   try{
//   //
//   //       if(selectedImage?.value!="" && selectedImage?.value!=null){
//   //         String? imageResp=await _offerRepository.offerPicUpload(selectedImage!.value!);
//   //         if(imageResp!=null){
//   //
//   //           Map<String,dynamic> _offerData = {
//   //             'businessId': businessId,
//   //             'offerTitle': offerTitle.text,
//   //             'description': description.text,
//   //             'offerType': offerType.text,
//   //             'discountAmount': discountAmount.text,
//   //             'offerCode': offerCode.text,
//   //             'offerBanner': imageResp
//   //           };
//   //
//   //           bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
//   //           if(response==true){
//   //             fetchOffers(businessId);
//   //             Get.off(()=> OffersScreen());
//   //           }
//   //       }
//   //       }
//   //       else if(selectedOffer!=null && selectedOffer!=""){
//   //         Map<String,dynamic> _offerData = {
//   //           'businessId': businessId,
//   //           'offerTitle': offerTitle.text,
//   //           'description': description.text,
//   //           'offerType': offerType.text,
//   //           'discountAmount': discountAmount.text,
//   //           'offerCode': offerCode.text
//   //         };
//   //
//   //         bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
//   //         if(response==true){
//   //           fetchOffers(businessId);
//   //           Get.off(()=> OffersScreen());
//   //         }
//   //       }
//   //
//   //
//   //   }on FirebaseException catch(e){
//   //     debugPrint(e.message);
//   //   }finally {
//   //     resetTextFields();
//   //     isLoading.value = false;
//   //   }
//   // }
//   //
//   // Future<void> deleteBusinessOffer(String offerId) async{
//   //   isLoading.value=true;
//   //   try{
//   //     bool? result= await _businessRepository.deleteOffer(offerId);
//   //     if(result!=null && result){
//   //       offers.removeWhere((element) => element.id==offerId);
//   //     }
//   //   }on FirebaseException catch(e){
//   //     debugPrint(e.message);
//   //   }finally {
//   //      Get.back();
//   //     isLoading.value = false;
//   //   }
//   // }
//   //
//   // Future<void> fetchOffers(String?  businessId) async{
//   //   isLoading.value=true;
//   //   try{
//   //     List<Product>? response = await _offerRepository.fetchOffers(businessId!);
//   //     if(response!=null){
//   //      // setBusinessData=response;
//   //       offers.clear();
//   //       offers.addAll(response);
//   //
//   //       for (var offer in offers) {
//   //         offer.offerBanner = await fetchImgUrl(offer.offerBanner!);
//   //       }
//   //     }
//   //     else{
//   //       Get.to(()=>AddBusiness());
//   //     }
//   //   }on FirebaseException catch(e){
//   //     debugPrint(e.message);
//   //   }finally {
//   //     offers.refresh();
//   //     isLoading.value = false;
//   //   }
//   // }
//   //
//   // String? cityFieldValidator(String? value) {
//   //   String? errorMsg;
//   //   if (value==null || value=="") {
//   //     errorMsg="City can't be empty";
//   //   } else if (CitiesService.cities.contains(value)==false) {
//   //     errorMsg="City is not valid kindly select from list.";
//   //   }
//   //   return errorMsg;
//   // }
//   //
//   // List<String> offerTypes=["Percentage Discount","Flat Discount","Free Item"];
//   //
//   // String? offerTypeValidator(String? value) {
//   //   String? errorMsg;
//   //   if (value==null || value=="") {
//   //     errorMsg="Type can't be empty";
//   //   } else if (offerTypes.contains(value)==false) {
//   //     errorMsg="Offer type is not valid kindly select from list.";
//   //   }
//   //   return errorMsg;
//   // }
//
//
//   void validateAndSubmit(String businessId){
//     // if (addOfferFormKey.currentState!.validate()) {
//     //   addOffer(businessId);
//     // }
//   }
//
//   void validateAndUpdate(String business){
//     // if (updateOfferFormKey.currentState!.validate()) {
//     //   editOffer(business??"");
//     // }
//   }
//
//
//   Future<String?> fetchImgUrl(String photo)async {
//     return await FirebaseService.getImageUrl(photo);
//   }
//
//   var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
//   Random _rnd = Random();
//
//   String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
//       length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
// }