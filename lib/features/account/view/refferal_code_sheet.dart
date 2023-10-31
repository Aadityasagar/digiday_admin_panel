import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/auth/controllers/two_factor.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_controller.dart';

class ReferalCoeSheet extends StatelessWidget {
  const ReferalCoeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AccountController _accountController=Get.find<AccountController>();
    TwoFactor _twoFactor=Get.find<TwoFactor>();

    TextFormField buildReferrealCodeFormField() {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _accountController.referralCode,
        decoration: const InputDecoration(
          labelText: "Referral Code",
          hintText: "Enter Referral Code",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always
        ),
      );
    }

    return GetBuilder<TwoFactor>(
        builder: (business) =>  Container(
            height: 300,
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
                        "Any one referred you?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color:Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      const Text("If you have been referred by someone kindly enter their referral code.",
                        textAlign: TextAlign.center,
                        style:  TextStyle(color:Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      buildReferrealCodeFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: DefaultButton(
                          text: 'Submit',
                          press: (){
                            _twoFactor.sendOtp();
                          },
                        ),
                      ),

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
