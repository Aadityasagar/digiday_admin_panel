import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/subscriptions/controllers/subscription_controller.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionsScreen extends StatelessWidget {
   SubscriptionsScreen({Key? key}) : super(key: key);
 final  SubscriptionController _subscriptionController=Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Scaffold(
         // floatingActionButton: FloatingActionButton(child: Text("Token"),onPressed: _subscriptionController.getTokenFromPaytm,),
          appBar: AppBar(
            title: Text('Choose Plan', style: headingStyle,),
          ),


          body: Obx(()=> Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),

              Visibility(
                visible: _subscriptionController.getSubsciptionData!=null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black
                    ),

                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20),horizontal: getProportionateScreenWidth(40)),
                      child: Column(
                        children: [
                           Text("You are subscribed to ${_subscriptionController.getSubsciptionData?.currentPlanName}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                           textAlign: TextAlign.center,),
                          Text("₹${_subscriptionController.getSubsciptionData?.currentPlanRate}",
                            style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: Colors.white
                            ),),
                          Padding(
                            padding:  EdgeInsets.all(getProportionateScreenWidth(2)),
                            child: Text("This pack is valid for ${_subscriptionController.getSubsciptionData?.currentPlanValidity} days only.",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(getProportionateScreenWidth(2)),
                            child: Text("Last recharge done on ${DateFormat.yMMMEd().format(_subscriptionController.getSubsciptionData?.lastRechargeDate??DateTime.now())}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(getProportionateScreenWidth(2)),
                            child: Text("Next recharge date ${DateFormat.yMMMEd().format(_subscriptionController.getSubsciptionData?.nextRechargeDate??DateTime.now())}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),),
                          ),

                        ],
                      ),
                    ),

                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),

              const Text("Team Plans Available",
                style:  TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Text("To continue using this application kindly purchase a plan.",
                  style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),



              _subscriptionController.isLoading.value? const SizedBox():  Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView.builder(
                  itemCount: _subscriptionController.vendorPlans.length,
                  itemBuilder: (BuildContext context, int i){
                    return SubscriptionCard(
                      name: _subscriptionController.vendorPlans[i].planName??"",
                      price: _subscriptionController.vendorPlans[i].planPrice??0,
                      validity:_subscriptionController.vendorPlans[i].planValidity??0,
                      color: _subscriptionController.vendorPlans[i].planName=="Gold Plan"? Colors.amber.shade600 : Colors.grey,
                      press: () {

    if(_subscriptionController.getSubsciptionData?.status=="Active"){
    CommonFunctions.showSnackBar(title: "Alert", message: "You can't recharge before current plan expires!", type: PopupType.warning);
    }
    else {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(color: const Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Check Out", style: headingStyle,),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Container(decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),),
                      width: double.infinity,


                      child: SubscriptionCard(
                        press: () {

                          _subscriptionController.purchasePlan(
                              _subscriptionController.vendorPlans[i]
                                  .id.toString(),
                              _subscriptionController.vendorPlans[i]
                              .planPrice.toString(),
                            _subscriptionController.vendorPlans[i]
                                .planValidity!
                          );

                        },
                        name: _subscriptionController.vendorPlans[i].planName ??
                            "",
                        price: _subscriptionController.vendorPlans[i]
                            .planPrice ?? 0,
                        validity: _subscriptionController.vendorPlans[i]
                            .planValidity ?? 0,
                        color: _subscriptionController.vendorPlans[i]
                            .planName == "Gold" ? Colors.amber : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    InkWell(
                        onTap: () {
                          Get.back();


                          _subscriptionController.purchasePlan(
                              _subscriptionController.vendorPlans[i]
                                  .id.toString(),
                              _subscriptionController.vendorPlans[i]
                              .planPrice.toString(),
                              _subscriptionController.vendorPlans[i]
                                  .planValidity!
                          );
                        },
                        child: const PaymentButtons())

                  ],
                ),
              ),
            ),
          );
        },
      );
    }
                      },);

                  },
                ),
              )),


            ],

          )),

        ),

        Obx(() =>  Offstage(
            offstage: !_subscriptionController.isLoading.value,
            child:const AppThemedLoader()))
      ],
    );
  }
}

class PaymentButtons extends StatelessWidget {
  const PaymentButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid,color: Colors.black,),
        // borderRadius: const BorderRadius.all(Radius.circular(50))
        // ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/paytm.png', height: 60,),
                const Text('Pay with Paytm', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
                color: Colors.black),),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
            // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Image.asset('assets/images/razorpay.png', height: 60,),
            //     const Text('Razorpay', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20,
            //     color: Colors.black),),
            //     const Icon(Icons.arrow_forward_ios)
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class Subscription{
  String type;
  String price;
  String features;
  Color  color;

  Subscription({
    required this.type,
    required this.price,
    required this.features,
    required this.color
});


}

class SubscriptionCard extends StatelessWidget {
  String name;
  int price;
  int validity;
  Color  color;
  VoidCallback press;
  
   SubscriptionCard({Key? key,
    required this.name,
    required this.price,
    required this.validity,
    required this.color,
    required this.press
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color
          ),

          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                Text(name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
                Text("₹$price",
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                  ),),
                Padding(
                  padding:  EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Text("This pack is valid for ${validity} days only.",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),),
                )

              ],
            ),
          ),

        ),
      ),
    );
  }
}


