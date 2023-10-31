import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/subscriptions/controllers/subscription_controller.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({required this.status,super.key});
  final String status;


  @override
  Widget build(BuildContext context) {


    if(status=="Pending"){
      SubscriptionController _subscriptionController=Get.find<SubscriptionController>();
     // _subscriptionController.fetchSubscriptionStatusForPendingPayment();
    }


    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Login Success"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Image.asset(
              status=="Completed"?  "assets/images/check.png": "assets/images/cross.png",
              height: SizeConfig.screenHeight * 0.3, //40%
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              status=="Completed"? "Payment Completed!": status=="Pending"? "Payment Under Verification!":"Payment Failed!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              status=="Completed"? "Your subscription purchase is completed,successfully!":status=="Pending"? "Your payment is under verification,as payment gateway is taking longer than expected." : "Your subscription purchase is not completed,due to failed payment,deducted amount will be refunded.You can try again later!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Visibility(
              visible: status!="Pending",
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.6,
                child: DefaultButton(
                  text: "Back to home",
                  press: () {
                   Get.off(()=> HomeScreen(),arguments: {'status': status});
                  },
                ),
              ),
            ),
           const Spacer(),
          ],
        ),
      ),
    );
  }
}

