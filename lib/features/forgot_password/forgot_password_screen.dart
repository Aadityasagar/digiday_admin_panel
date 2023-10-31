import 'package:digiday_admin_panel/components/custom_surfix_icon.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/forgot_password/controller/forgot_password.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  ForgotPasswordController _controller=Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Forgot Password"),
          ),
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(28),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Please enter your email and we will send \nyou a link to return to your account",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    Form(
                      key: _controller.forgotForm,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _controller.email,
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if (value!.isEmpty && !_controller.email.text.contains(kEmailNullError)) {
                                return 'Email cant be empty!';
                              } else if (!emailValidatorRegExp.hasMatch(value)) {
                                return 'Email is not valid!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.1),
                          DefaultButton(
                            text: "Continue",
                            press: () {
                             _controller.validateAndSubmit();
                            },
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(() =>  Offstage(
            offstage: !_controller.isLoading.value,
            child: const AppThemedLoader()))
      ],
    );
  }
}
