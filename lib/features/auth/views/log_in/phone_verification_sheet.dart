import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/auth/controllers/two_factor.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../account/controller/account_controller.dart';

class PhoneVerificationSheet extends StatelessWidget {
  const PhoneVerificationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AccountController _accountController=Get.find<AccountController>();
    TwoFactor _twoFactor=Get.find<TwoFactor>();

    return GetBuilder<TwoFactor>(
        builder: (business) =>  Container(
            height: _twoFactor.isOtpSent.value?300:260,
            decoration:const  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )
            ),
            child:Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                      const Text(
                        "Verify your phone number",
                        textAlign: TextAlign.center,
                        style: TextStyle(color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text("+91 ${_accountController.getCurrentUser?.phone??""}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color:Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      const Text("One time password will be sent sent on this phone number",
                        textAlign: TextAlign.center,
                        style:  TextStyle(color:Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      Offstage(
                        offstage: _twoFactor.isOtpSent.value!=true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: OTPTextField(
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 50,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 10,
                            style: TextStyle(fontSize: 17),
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                            },
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: _twoFactor.isOtpSent.value,
                        child: SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                      ),
                      Offstage(
                        offstage: _twoFactor.isOtpSent.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: DefaultButton(
                            text: 'Send Now',
                            press: (){
                              _twoFactor.sendOtp();
                            },
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: _twoFactor.isOtpSent.value!=true,
                        child: SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                      ),
                      Offstage(
                        offstage: _twoFactor.isOtpSent.value!=true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: DefaultButton(
                            text: 'Verify',
                            press: (){
                              _twoFactor.sendOtp();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Obx(() =>  Offstage(
                    offstage: !_twoFactor.isLoading.value,
                    child: const AppThemedLoader()))
              ],
            )
        ));
  }
}
