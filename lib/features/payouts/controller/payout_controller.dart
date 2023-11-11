
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/constants/firebase_keys.dart';
import 'package:digiday_admin_panel/features/business/data/business_repository.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/features/payouts/data/payout_model.dart';
import 'package:digiday_admin_panel/features/payouts/data/payout_repository.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../products/data/product_model.dart';

class PayoutController extends GetxController{
  RxBool isLoading = false.obs;
  final BusinessRepository _businessRepository = BusinessRepository();
  final PayoutRepository _payoutRepository = PayoutRepository();


  final addOfferFormKey = GlobalKey<FormState>();
  final updateOfferFormKey = GlobalKey<FormState>();


  RxList<Payout> payouts=<Payout>[].obs;
  RxList<Product> products=<Product>[].obs;






  @override
  void onInit() {
    fetchPayouts();
    super.onInit();
  }


  Future<void> fetchPayouts() async {
    isLoading.value = true;
    try {
      List<Payout>? response = await _payoutRepository.fetchPayouts();
      if (response != null) {
        // setBusinessData=response;
        payouts.clear();
        payouts.addAll(response);
        update();
      }
      else {
        // Get.to(() => AddBusiness());
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } finally {
      payouts.refresh();
      isLoading.value = false;
    }
  }

  Future<void> transferMoney(
      String name,
      String account_number,
      String phone,
      String amount,
      String ifsc,
      String clientid,
      int index,
      String wallet
      ) async{

       String url='https://digidayapp.serveravatartmp.com/payout/transfer.php';

    isLoading.value=true;
    try{

      Map<String,dynamic> body={
          'key': 'hikesmoney',
          'amount': amount,
          'phone': phone,
          'ifsc': ifsc,
          'name': name,
          'account_number': account_number,
          'token': 'xGPbzKW0if4U38uiTCrV2jlLPfWRixfrIfMMuGA6AiuZ2cmdVyfKC7CQz854'
      };
      http.Response resp=await http.post(Uri.parse(url),body: body);
      if(resp.statusCode==200){
        debugPrint(resp.body);

        var result= jsonDecode(resp.body);
        if(result!=null){
          if(result['status']=="success" && result.contains("orderid")){
            payouts.removeAt(index);
            Map<String,dynamic> data={
              'status': 'Completed'
            };
            await FirebaseService.updateDocById(data, wallet, FirebaseKeys.payoutsCollection);
            update();
            CommonFunctions.showSnackBar(title: "Success", message: "Amount Transferred successfully.", type: PopupType.success);
          }
          else{
            CommonFunctions.showSnackBar(title: "Error", message: "Amount Not Transferred.", type: PopupType.error);

          }
        }
      }
    }
    on Exception catch(e){
     // debugPrint(e);
    }
    finally{
      isLoading.value=false;
    }
  }

}