import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/payouts/components/payout_card.dart';
import 'package:digiday_admin_panel/features/payouts/controller/payout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayoutScreen extends StatelessWidget {
  const PayoutScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final PayoutController _payoutController=Get.put(PayoutController());

    return GetBuilder<PayoutController>(
        builder: (business) =>   Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  title: Text("Process Payouts", style: headingStyle),
                ),

                body:  Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,
                        horizontal: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child:  _payoutController.payouts.length!=0 ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _payoutController.payouts.length,
                              itemBuilder: (BuildContext context, int index) {

                                return PayoutCard(
                                  index: index,
                                  payoutData: _payoutController.payouts[index],
                                );
                              }
                          ): const Center(child: Text("No Payout requests!")),
                        ),
                      ],
                    ),
                  ),
                )
            ),

            Obx(() =>  Offstage(
                offstage: !_payoutController.isLoading.value,
                child: AppThemedLoader()))
          ],
        )
      );

  }

}




