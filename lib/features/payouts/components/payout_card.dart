import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/payouts/controller/payout_controller.dart';
import 'package:digiday_admin_panel/features/payouts/data/payout_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayoutCard extends StatelessWidget {
  const PayoutCard({
    Key? key,
    required this.payoutData,
    required this.index,
  }) : super(key: key);

  final Payout payoutData;
  final int index;



  @override
  Widget build(BuildContext context) {

    PayoutController _payoutController=Get.find<PayoutController>();

    return Container(
      width:( MediaQuery.of(context).size.width/1)-50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: (){

            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(color: const Color(0xFF737373),
                  height: MediaQuery.of(context).size.height/1.2,
                  child: Container(decoration: BoxDecoration(color: Colors.blue.shade50,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25), topLeft:Radius.circular(25) )),
                  ),
                );
              },
            );
          },
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Name :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              width : 10
                            ),
                            Text("${payoutData.name}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [

                            const Text("Amount :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Text("₹${payoutData.amount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            const Text('Status :',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Text(payoutData.status ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              maxLines: 1,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                         Row(
                          children: [
                            Expanded(
                              child: Text("Account Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                maxLines: 2,),
                            )
                          ],
                        ),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Account Holder :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),

                                const SizedBox(
                                  width: 20,
                                ),

                                Text(payoutData.account_holder ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Account Number :",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),

                                const SizedBox(
                                  width: 20,
                                ),

                                Text(payoutData.account_number ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Bank Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),

                                const SizedBox(
                                  width: 20,
                                ),

                                Text(payoutData.bank_name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("IFS Code :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),

                                const SizedBox(
                                  width: 20,
                                ),

                                Text(payoutData.ifsc?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
                          child: DefaultButton(
                            text: "Transfer",
                            press: (){
                              _payoutController.transferMoney(payoutData.account_holder ?? "",
                                  payoutData.account_number?? "",
                                  payoutData.phone?? "",
                                  payoutData.amount.toString()?? "",
                                  payoutData.ifsc?? "",
                                  payoutData.phone?? "",
                                  index,
                                   payoutData.wallet?? ""
                              );
                            },
                          ),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}