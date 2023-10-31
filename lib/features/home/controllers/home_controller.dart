import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/auth/controllers/two_factor.dart';
import 'package:digiday_admin_panel/features/payment_success/payment_response_screen.dart';
import 'package:digiday_admin_panel/features/subscriptions/controllers/subscription_controller.dart';
import 'package:get/get.dart';

import '../../account/controller/account_controller.dart';

class HomeController extends GetxController{
  final AppSessionController _appState = Get.find<AppSessionController>();
  RxBool isLoading = false.obs;
  AccountController _accountController=Get.put(AccountController());
  SubscriptionController _subscriptionController=Get.put(SubscriptionController());
  final TwoFactor _twoFactor=Get.put(TwoFactor());

  @override
  void onReady() {
    super.onReady();
    _accountController.fetchProfileData();
      _subscriptionController.fetchSubscriptionData().then((value) => {
      });

  }



void getArguments()async{
    var args=Get.arguments;
    if(args!=null && args.containsKey("status")){

      if(args['status']=="Failed"){
        _subscriptionController.fetchSubscriptionData();
      }else if(args['status']=="Completed"){

      }
      else if(args['status']=="Delay"){
        Get.off(()=> const PaymentSuccessScreen(status: "Delay"));
      }

    }
}


void onClick(){
    _subscriptionController.creditRewards();
}



}