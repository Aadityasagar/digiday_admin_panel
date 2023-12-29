import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/models/plan_model.dart';
import 'package:digiday_admin_panel/models/reward_config_model.dart';
import 'package:digiday_admin_panel/screens/reward_config/data/reward_config_repository.dart';
import 'package:digiday_admin_panel/screens/subscribers/data/subscribers_repository.dart';
import 'package:flutter/material.dart';

class RewardConfigProvider extends ChangeNotifier{
final RewardConfigRepository _rewardConfigRepository=RewardConfigRepository();
final SubscribersRepository _subscribersRepository=SubscribersRepository();

TextEditingController first=TextEditingController();
TextEditingController second=TextEditingController();
TextEditingController third=TextEditingController();
TextEditingController fourth=TextEditingController();
TextEditingController fifth=TextEditingController();
final editRewardConfigFormKey = GlobalKey<FormState>();

void resetTextFields(){
  first.clear();
  second.clear();
  third.clear();
  fourth.clear();
  fifth.clear();
}

bool isLoading=false;
List<RewardConfig> rewardConfigList=<RewardConfig>[];
DocumentSnapshot<Object?>? lastDocument;
int currentPage=1;
int itemsPerPageLimit=100;
int totalItems=10;

RewardConfig? selectedRewardConfig;


///This works like init method
RewardConfigProvider(){
fetchRewardConfigData();
}

void selectRewardConfigToEdit(RewardConfig rewardConfigToEdit){
  selectedRewardConfig=rewardConfigToEdit;
  first.text=rewardConfigToEdit.first??"";
  second.text=rewardConfigToEdit.second??"";
  third.text=rewardConfigToEdit.third??"";
  fourth.text=rewardConfigToEdit.fourth??"";
  fifth.text=rewardConfigToEdit.fifth??"";
}

Future<bool> editRewardConfig() async{
  bool response=false;
  isLoading=true;
  notifyListeners();
  try{
    Map<String,dynamic> _rewardConfig = {
      'first': first.text,
      'second': second.text,
      'third': third.text,
      'fourth': fourth.text,
      'fifth': fifth.text
    };

    response=await _rewardConfigRepository.editRewardConfig(_rewardConfig,selectedRewardConfig!.id!)??false;
    return response;

  }on FirebaseException catch(e){
    debugPrint(e.message);
    rethrow;
  }finally {
    selectedRewardConfig=null;
    resetTextFields();
    isLoading=false;
    fetchRewardConfigData();
  }
}

Future<bool> validateAndEdit()async{
  bool result=false;
  if (editRewardConfigFormKey.currentState!.validate()) {
    try {
      result= await editRewardConfig();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  return result;
}

Future<void> fetchRewardConfigData() async {
  rewardConfigList.clear();
  isLoading = true;

  notifyListeners();

  try {
    QuerySnapshot? response = await _rewardConfigRepository.fetchRewardsConfigData(
        limitPerPage: itemsPerPageLimit,
        lastDocument: lastDocument
    );

    if (response!= null) {
      processRewardConfigData(response);
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
  fetchRewardConfigData();
}

Future<Plan?> fetchVendorPlanDetails(String planId) async {
  DocumentSnapshot? documentSnapshot =
  await _subscribersRepository.fetchVendorPlanDetails(planId: planId);
  if (documentSnapshot != null) {
    Map<String, dynamic>? subData = documentSnapshot.data() as Map<String, dynamic>?;
    if (subData != null) {
      Plan result = Plan(
          id: documentSnapshot.id,
          rate: subData['rate'],
          name: subData['name'],
          validityInDays: subData['validityInDays']
      );

      return result;
    }
  }
}

Future<Plan?> fetchCmPlanDetails(String planId) async {
  DocumentSnapshot? documentSnapshot =
  await _subscribersRepository.fetchCmPlanDetails(planId: planId);
  if (documentSnapshot != null) {
    Map<String, dynamic>? subData =
    documentSnapshot.data() as Map<String, dynamic>?;
    if (subData != null) {
      Plan result = Plan(
          id: documentSnapshot.id,
          rate: subData['rate'],
          name: subData['name'],
          validityInDays: subData['validityInDays']
      );
      return result;
    }
  }
  return null;
}

void processRewardConfigData(QuerySnapshot snapshot)async{
  try{
    if (snapshot != null) {
      for (var element in snapshot.docs) {
        var data = element.data() as Map<String, dynamic>;
        if (data != null) {

          RewardConfig rewardConfigData= RewardConfig(
            id: element.id,
            planId: data['planId'],
            first: data['first'],
            second: data['second'],
            third: data['third'],
            fourth: data['fourth'],
            fifth: data['fifth']
          );

          if(data['planId']!=null){
            Plan? planData = await fetchVendorPlanDetails(data['planId']);
            rewardConfigData.planDetails=planData;
          }

          if(data['planId']!=null){
            Plan? planData = await fetchCmPlanDetails(data['planId']);
            rewardConfigData.planDetails=planData;
          }

          rewardConfigList.add(rewardConfigData);
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