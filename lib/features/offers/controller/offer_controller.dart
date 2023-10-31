// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hikesmoney/features/business/add_business.dart';
// import 'package:hikesmoney/features/business/controllers/business_controller.dart';
// import 'package:hikesmoney/features/business/data/business_repository.dart';
// import 'package:hikesmoney/features/offers/data/offer_repository.dart';
// import 'package:hikesmoney/features/offers/edit_offer.dart';
// import 'package:hikesmoney/features/offers/offers_screen.dart';
// import 'package:hikesmoney/features/products/data/product_model.dart';
// import 'package:hikesmoney/utils/services/city_service.dart';
// import 'package:hikesmoney/utils/services/network/firebase_service.dart';
// import 'package:image_picker/image_picker.dart';
// import '../data/offer_model.dart';
//
// class OfferController extends GetxController{
//   RxBool isLoading = false.obs;
//   final BusinessRepository _businessRepository = BusinessRepository();
//   final PayoutRepository _offerRepository = PayoutRepository();
//
//   TextEditingController offerTitle=TextEditingController();
//   TextEditingController description=TextEditingController();
//   TextEditingController offerType=TextEditingController();
//   TextEditingController discountAmount = TextEditingController();
//   TextEditingController offerCode = TextEditingController();
//   TextEditingController offerBanner = TextEditingController();
//
//   final addOfferFormKey = GlobalKey<FormState>();
//   final updateOfferFormKey = GlobalKey<FormState>();
//
//
//
//
//   RxString? selectedImage="".obs;
//
//   RxList<Offer> offers=<Offer>[].obs;
//   RxList<Product> products=<Product>[].obs;
//
//   Offer? selectedOffer;
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
//     setDefaults();
//     super.onInit();
//   }
//
//
//   void setDefaults(){
//     if(selectedOffer==null){
//       offerCode.text=getRandomString(8);
//     }
//   }
//
//   void resetTextFields(){
//    offerTitle.clear();
//    description.clear();
//    offerType.clear();
//    discountAmount.clear();
//    offerCode.clear();
//    offerBanner.clear();
//    selectedImage?.value="";
//   }
//
//
//   void navigateToEditScreen(Offer offer){
//     selectedOffer=offer;
//     resetTextFields();
//     loadTextFields();
//     Get.back();
//     Get.to(()=> const EditOffer());
//   }
//
//   void loadTextFields(){
//     offerTitle.text=selectedOffer?.offerTitle??"";
//     description.text=selectedOffer?.description??"";
//     offerType.text =selectedOffer?.offerType??"";
//     discountAmount.text =selectedOffer?.discountAmount??"";
//     offerCode.text =selectedOffer?.offerCode??"";
//     offerBanner.text = selectedOffer?.offerBanner??"";
//   }
//
//
//   Future<void> addOffer(String businessId) async{
//     isLoading.value=true;
//     try{
//
//       String? imageResp=await _offerRepository.offerPicUpload(selectedImage!.value!);
//
//      if(imageResp!=null){
//        Map<String,dynamic> _offerData = {
//          'businessId': businessId,
//          'offerTitle': offerTitle.text,
//          'description': description.text,
//          'offerType': offerType.text,
//          'discountAmount': discountAmount.text,
//          'offerCode': offerCode.text,
//          'offerBanner': imageResp
//        };
//
//        bool? response=await _offerRepository.addOffer(_offerData);
//        if(response==true){
//          fetchOffers(businessId);
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
//   Future<void> editOffer(String businessId) async{
//     isLoading.value=true;
//     try{
//
//         if(selectedImage?.value!="" && selectedImage?.value!=null){
//           String? imageResp=await _offerRepository.offerPicUpload(selectedImage!.value!);
//           if(imageResp!=null){
//
//             Map<String,dynamic> _offerData = {
//               'businessId': businessId,
//               'offerTitle': offerTitle.text,
//               'description': description.text,
//               'offerType': offerType.text,
//               'discountAmount': discountAmount.text,
//               'offerCode': offerCode.text,
//               'offerBanner': imageResp
//             };
//
//             bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
//             if(response==true){
//               fetchOffers(businessId);
//               Get.off(()=> OffersScreen());
//             }
//         }
//         }
//         else if(selectedOffer!=null && selectedOffer!=""){
//           Map<String,dynamic> _offerData = {
//             'businessId': businessId,
//             'offerTitle': offerTitle.text,
//             'description': description.text,
//             'offerType': offerType.text,
//             'discountAmount': discountAmount.text,
//             'offerCode': offerCode.text
//           };
//
//           bool? response=await _offerRepository.updateOffer(selectedOffer?.id,_offerData);
//           if(response==true){
//             fetchOffers(businessId);
//             Get.off(()=> OffersScreen());
//           }
//         }
//
//
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
//
//   Future<void> deleteBusinessOffer(String offerId) async{
//     isLoading.value=true;
//     try{
//       bool? result= await _businessRepository.deleteOffer(offerId);
//       if(result!=null && result){
//         offers.removeWhere((element) => element.id==offerId);
//       }
//     }on FirebaseException catch(e){
//       debugPrint(e.message);
//     }finally {
//        Get.back();
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchOffers(String?  businessId) async{
//     isLoading.value=true;
//     try{
//       List<Offer>? response = await _offerRepository.fetchPayouts(businessId!);
//       if(response!=null){
//        // setBusinessData=response;
//         offers.clear();
//         offers.addAll(response);
//
//         for (var offer in offers) {
//           offer.offerBanner = await fetchImgUrl(offer.offerBanner!);
//         }
//       }
//       else{
//         Get.to(()=>AddBusiness());
//       }
//     }on FirebaseException catch(e){
//       debugPrint(e.message);
//     }finally {
//       offers.refresh();
//       isLoading.value = false;
//     }
//   }
//
//   String? cityFieldValidator(String? value) {
//     String? errorMsg;
//     if (value==null || value=="") {
//       errorMsg="City can't be empty";
//     } else if (CitiesService.cities.contains(value)==false) {
//       errorMsg="City is not valid kindly select from list.";
//     }
//     return errorMsg;
//   }
//
//   List<String> offerTypes=["Percentage Discount","Flat Discount","Free Item"];
//
//   String? offerTypeValidator(String? value) {
//     String? errorMsg;
//     if (value==null || value=="") {
//       errorMsg="Type can't be empty";
//     } else if (offerTypes.contains(value)==false) {
//       errorMsg="Offer type is not valid kindly select from list.";
//     }
//     return errorMsg;
//   }
//
//
//   void validateAndSubmit(String businessId){
//     if (addOfferFormKey.currentState!.validate()) {
//       addOffer(businessId);
//     }
//   }
//
//   void validateAndUpdate(String business){
//     if (updateOfferFormKey.currentState!.validate()) {
//       editOffer(business??"");
//     }
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