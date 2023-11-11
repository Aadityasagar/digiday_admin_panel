import 'dart:convert';
import 'dart:io';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:digiday_admin_panel/features/account/data/models/subscription_model.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/views/log_in/sign_in_screen.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/features/home/home_screen.dart';
import 'package:digiday_admin_panel/features/payment_success/payment_response_screen.dart';
import 'package:digiday_admin_panel/features/subscriptions/data/model/vendor_plan_model.dart';
import 'package:digiday_admin_panel/features/subscriptions/data/subscription_repository.dart';
import 'package:digiday_admin_panel/features/subscriptions/views/paytm_webview.dart';
import 'package:digiday_admin_panel/features/subscriptions/views/subscripitons_screen.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubscriptionController extends GetxController{
  final SubscriptionRepository _subRepo = SubscriptionRepository();
  final AppSessionController _appState = Get.find<AppSessionController>();
  final AccountController _accountController = Get.find<AccountController>();

  RxBool isLoading = false.obs;

  RxList<VendorPlan> vendorPlans=<VendorPlan>[].obs;
  String? queryString;

  String? selectedPlanId;
  String? currentOrderId;
  int? currentPlanValidity;

  SubscriptionData? _subscriptionData;

  SubscriptionData? get getSubsciptionData => _subscriptionData;

  set setSubScriptionData(SubscriptionData? value) {
    _subscriptionData = value;
  }

  @override
  void onReady() {
    super.onReady();
    checkForNoPaymentPayment();
    fetchPlans();
  }



void checkForNoPaymentPayment(){
    // if(_appState.lastPendingOrder!=null){
    //   fetchSubscriptionData();
    // }
    // else{
    //  Get.off(()=> const PaymentSuccessScreen(status: "Delay"));
    // }
}


  Future<void> fetchSubscriptionStatusForPendingPayment() async {
    try {
      isLoading.value = true;

      Map<String,dynamic>? status = await _subRepo.fetchSubscriptionStatusPendingPayment();

      if(status!=null){

        if(status.containsKey("planStatus")){
          String subStatus=status['planStatus'];
          String nextRechargeDate=status['nextRechargeDate'];

          _appState.setSubStatus = subStatus;
          _appState.setNextRechargeDate = nextRechargeDate;


          if(subStatus!="Active"){
            CommonFunctions.showAppThemedAlert(message: "You don't have a active subscription.",header: "ALERT",actions: [
              ActionButton("Buy Now", () {
                Get.to(()=> SubscriptionsScreen());
              }),
              ActionButton("Exit App", () {
                exit(0);
              }),
            ]);

          }
          else{

            Get.to(()=> HomeScreen(),arguments: {'status': "Completed"});
          }
        }

      }

      isLoading.value = false;
    } on ApiException catch (e) {
      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: e.message,
        actions: [
          ActionButton("Ok", () {
            Get.back();
          })
        ],
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  ///This method fetchs all available plans
  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;

      List<VendorPlan>? plans = await _subRepo.fetchTeamPlans();

      if(plans!=null){
        vendorPlans.addAll(plans);
      }

      isLoading.value = false;
    } on ApiException catch (e) {
      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: e.message,
        actions: [
          ActionButton("Ok", () {
            Get.back();
          })
        ],
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  ///This method invokes paytm payment flow in web view
  Future<void> purchasePlan(String planId,
      String amount,
      int planValidity,
      )async{

    try {
      isLoading.value = true;
      selectedPlanId=planId;
      currentPlanValidity=planValidity;
      String? orderId = await _subRepo.purchasePlan(planId, amount);

      if(orderId!=null){
        currentOrderId=orderId;
        getPaytmToken(amount, orderId);
      }
    }on ApiException catch (e) {
      return CommonFunctions.showDialogBox(
        popupType: PopupType.error,
        message: e.message,
        actions: [
          ActionButton("Ok", () {
            Get.back();
          })
        ],
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  ///This method fetches paytm txn token
  Future<void> getPaytmToken(String amount,String orderId) async {
    isLoading.value = true;

   String? uuid = await _appState.getLoggedInUsersUid();

   var payload = <String, String> {
      "TXN_AMOUNT": amount,
      "CUST_ID": uuid!,
      "ORDER_ID": orderId,
      "PRODUCT_ID": "12",
      "INDUSTRY_TYPE_ID":"ECommerce",
      "CHANNEL_ID":"WAP",
      "PHN": "",
       "api_token":"kdk1blOGXurIdcLTLG8lw5hdPtnsAQ5s"
    };


    Uri link=Uri.parse(ApiUrl.kGetPaytmTokenFromServer);
    var response = await http.post(link, body: payload);
    if(response.statusCode==200){
      var resp=jsonDecode(response.body);
      if(resp!=null){
        Map<String,dynamic> params=resp['data']['params'] as Map<String,dynamic>;
        params.addAll({
          'CHECKSUMHASH': resp['data']['token']
        });

         queryString = Uri(queryParameters: params).query;
         Get.to(()=> PaytmWebView());
      }
    }


  }

  ///This method process payment response
  Future<void> processResponse(response) async{
    var resp=jsonDecode(response);
    if(resp['code']==200){

      String status="Pending";

      if(resp['data']=="TXN_SUCCESS"){
        await updateOrder("Completed");
        status="Completed";
      }
      else if(resp['data']=="PENDING"){
        await updateOrder("Pending");
        status="Pending";

        if(currentOrderId!=null){
          SharedPreferenceRef.instance.setLastPendingOrder(currentOrderId!);
        }

      }
      else if(resp['data']=="TXN_FAILURE"){
        await updateOrder("Failed");
        status="Failed";
      }
      else{
        await updateOrder("Unknown");
        status="Unknown";
      }

      Get.offAll(()=> PaymentSuccessScreen(status: status));

    }
    else{
      updateOrder("Failed");
      Get.offAll(()=> const PaymentSuccessScreen(status: "Failed"));
    }
  }

  ///This method updates status of payment
  Future<void> updateOrder(String status)async{
    if(currentOrderId!=null){
      await _subRepo.upDateStatus(
          currentOrderId!,
          selectedPlanId!,
          status,
          currentPlanValidity!);

      currentOrderId=null;
      selectedPlanId=null;
    }
  }

  ///This method fetch all subscription data
  Future<void> fetchSubscriptionData() async{
    try{
      SubscriptionData? subData = await _subRepo.fetchSubscriptionData();
      if(subData!=null && subData.status=="Active"){
        setSubScriptionData=subData;
      }
      else{
        debugPrint("User has no subscription / subscription expired");
       // Get.to(()=> SubscriptionsScreen());
      }
    }
    on ApiException catch(e){
      if(e.status==ApiExceptionCode.sessionExpire){
        CommonFunctions.showSnackBar(title: "Alert", message: "Session Expired", type: PopupType.error);
        Get.offAll(()=> LogInScreen());
      }
    }

  }



  List<String> family = [];

  Future<void> creditRewards() async {
    family.clear();
    String myParent = _accountController.getCurrentUser?.referredBy ?? "";
    await fetchParent(myParent);
  }

  Future<void> fetchParent(String code) async {
    try {
      if (family.length >= 5) {
        // Limit the family tree depth to 5.
        return;
      }
      Map<String, dynamic>? parentData = await _subRepo.fetchParentId(code);
      if (parentData != null) {
        if (parentData['referredBy'] != "" && parentData['referredBy'] != null) {
          family.add(parentData['id']);
          await fetchParent(parentData['referredBy']);
        }
      }
    } catch (e) {
      // Handle the exception, e.g., log it for debugging.
      print("Error in fetchParent: $e");
    }
  }




}