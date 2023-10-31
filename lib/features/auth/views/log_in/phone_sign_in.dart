import 'package:digiday_admin_panel/components/custom_surfix_icon.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/components/no_account_text.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/auth/controllers/login_controller.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/forgot_password/forgot_password_screen.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PhoneLogInScreen extends StatelessWidget {
  final LoginController _loginController=Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.04),
                        Image.asset("assets/images/logo-rec.png",width: 250,),
                        const Text(
                          "Sign in with your phone number",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        Form(
                          key: _loginController.emailLoginForm,
                          child: Column(
                            children: [
                              buildEmailFormField(),
                              SizedBox(height: getProportionateScreenHeight(30)),
                              buildPasswordFormField(),
                              SizedBox(height: getProportionateScreenHeight(30)),
                              Row(
                                children: [
                                  Obx(()=> Checkbox(
                                    value: _loginController.rememberMe.value,
                                    activeColor: kPrimaryColor,
                                    onChanged: (value) {
                                      _loginController.rememberMe.value=value!;
                                    },
                                  )),
                                  const Text("Remember me"),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, ForgotPasswordScreen.routeName),
                                    child: const Text(
                                      "Forgot Password",
                                      style: TextStyle(decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: getProportionateScreenHeight(20)),
                              DefaultButton(
                                text: "Login",
                                press: () {
                                  _loginController.validateAndSubmit();
                                },
                              ),
                            ],
                          ),
                        ),


                        SizedBox(height: getProportionateScreenHeight(20)),
                        NoAccountText(),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ),
        Obx(() =>  Offstage(
            offstage: !_loginController.isLoading.value,
            child: AppThemedLoader()))
      ],
    );
  }


  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _loginController.passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _loginController.email,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
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
    );
  }
}
