import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/account/data/models/user_model.dart';
import 'package:digiday_admin_panel/screens/vendors/data/vendor_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorController extends GetxController{
  final VendorRepository _vendorRepository= VendorRepository();

  RxBool isLoading=false.obs;

  RxList<UserData> vendorMates=<UserData>[].obs;

  @override
  void onInit() {
    fetchVendorData();
    super.onInit();
  }



  Future<void> fetchVendorData() async {
    isLoading.value = true;
    try {
      List<UserData>? response = await _vendorRepository.fetchVendorData();
      if (response!= null) {
        // setBusinessData=response;
        vendorMates.addAll(response);
        update();
      }
      else {
        // Get.to(() => AddBusiness());
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      vendorMates.refresh();
      isLoading.value = false;
    }
  }

}