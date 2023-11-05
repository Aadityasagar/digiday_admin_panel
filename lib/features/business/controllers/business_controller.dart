import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/business/add_business.dart';
import 'package:digiday_admin_panel/features/business/data/business_model.dart';
import 'package:digiday_admin_panel/features/business/data/business_repository.dart';
import 'package:digiday_admin_panel/features/business/my_shop_screen.dart';
import 'package:digiday_admin_panel/features/offers/controller/offer_controller.dart';
import 'package:digiday_admin_panel/utils/services/city_service.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:digiday_admin_panel/utils/services/state_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BusinessController extends GetxController{
  RxBool isLoading = false.obs;
  final BusinessRepository _businessRepository = BusinessRepository();
  final OfferController _offerController=Get.put(OfferController());
  TextEditingController businessName=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final addBusinessFormKey = GlobalKey<FormState>();
  final updateBusinessFormKey = GlobalKey<FormState>();

  BusinessData? _businessData;
  RxString? businessProfilePic="".obs;
  RxString? businessBannerPic="".obs;

  set setBusinessData(BusinessData? value) {
    _businessData = value;
  }

  BusinessData? get getBusinessData => _businessData;

  @override
  void onInit() {
    checkForBusinessData();
    super.onInit();
  }


  void checkForBusinessData(){
    if(_businessData==null){
      fetchBusinessDetails();
    }
  }




  Future<void> addBusiness() async{
    isLoading.value=true;
   try{


     String? uuid=await FirebaseService.getLoggedInUserUuId();

     Map<String,dynamic> _businessData = {
       'ownerId': uuid,
       'businessName': businessName.text,
       'address': addressController.text,
       'phoneNumber': phone.text,
       'city': cityController.text,
       'state': stateController.text,
       'pinCode': pincodeController.text,
       'profilePicture':'',
       'banner':''
     };

     bool? response=await _businessRepository.addBusiness(_businessData);
     if(response==true){
       // Get.off(()=>MyShopScreen());
     }
   }on FirebaseException catch(e){
     debugPrint(e.message);
   }finally {
     isLoading.value = false;
   }
  }


  void defaultValues(){
    businessName.text=getBusinessData?.businessName??"";
    addressController.text=getBusinessData?.address??"";
    cityController.text=getBusinessData?.city??"";
    stateController.text=getBusinessData?.state??"";
    phone.text=getBusinessData?.phoneNumber??"";
    pincodeController.text=getBusinessData?.pinCode??"";
  }

  Future<void> updateBusiness() async{
    isLoading.value=true;
    try{
      String? uuid=await FirebaseService.getLoggedInUserUuId();

      Map<String,dynamic> _businessData = {
        'ownerId': uuid,
        'businessName': businessName.text,
        'address': addressController.text,
        'phoneNumber': phone.text,
        'city': cityController.text,
        'state': stateController.text,
        'pinCode': pincodeController.text
      };

      bool? response=await _businessRepository.updateBusiness(getBusinessData?.id,_businessData);
      if(response==true){
        await fetchBusinessDetails();
        // Get.off(()=>MyShopScreen());
      }
    }on FirebaseException catch(e){
      debugPrint(e.message);
    }finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBusinessDetails() async{
    isLoading.value=true;
    try{
      BusinessData? response= await _businessRepository.fetchBusinessData();
      if(response!=null) {
        setBusinessData = response;
        // _offerController.fetchOffers(getBusinessData?.id);
      }
      else{
        Get.to(()=>AddBusiness());
      }
    }on FirebaseException catch(e){
      debugPrint(e.message);
    }finally {
      isLoading.value = false;
    }
  }



  String? cityFieldValidator(String? value) {
    String? errorMsg;
    if (value==null || value=="") {
      errorMsg="City can't be empty";
    } else if (CitiesService.cities.contains(value)==false) {
      errorMsg="City is not valid kindly select from list.";
    }
    return errorMsg;
  }

  String? stateFieldValidator(String? value) {
    String? errorMsg;
    if (value==null || value=="") {
      errorMsg="State can't be empty";
    } else if (StatesService.states.contains(value)==false) {
      errorMsg="State is not valid kindly select from list.";
    }
    return errorMsg;
  }


  void validateAndSubmit(){
    if (addBusinessFormKey.currentState!.validate()) {
       addBusiness();
    }
  }

  void validateAndUpdate(){
    if (updateBusinessFormKey.currentState!.validate()) {
      updateBusiness();
    }
  }

}