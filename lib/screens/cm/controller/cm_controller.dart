import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/features/account/data/models/user_model.dart';
import 'package:digiday_admin_panel/screens/cm/data/cm_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CmController extends GetxController{
  final CmRepository _myCmTeamRepository= CmRepository();

  RxBool isLoading=false.obs;

  RxList<UserData> cmTeamMates=<UserData>[].obs;

  @override
  void onInit() {
    fetchCmTeamData();
    super.onInit();
  }



  Future<void> fetchCmTeamData() async {
    isLoading.value = true;
    try {
      List<UserData>? response = await _myCmTeamRepository.fetchCmTeamData();
      if (response!= null) {
        // setBusinessData=response;
        cmTeamMates.addAll(response);
        update();
      }
      else {
        // Get.to(() => AddBusiness());
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      cmTeamMates.refresh();
      isLoading.value = false;
    }
  }

}