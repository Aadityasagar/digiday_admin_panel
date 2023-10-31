import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/auth/controllers/login_controller.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          largeScreen: getDesktopSignInScreen(context),
          mediumScreen: getTabSignInScreen(context),
          smallScreen: getMobileSignInScreen(context),
        ),
      ),
    );
  }

  Widget getMobileSignInScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "images/logo-rec.png",
                    width: 250,
                  ),
                  const Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _loginController.emailLoginForm,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        const SizedBox(height: 30),
                        buildPasswordFormField(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Obx(() => Checkbox(
                                  value: _loginController.rememberMe.value,
                                  activeColor: kPrimaryColor,
                                  onChanged: (value) {
                                    _loginController.rememberMe.value = value!;
                                  },
                                )),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: "Login",
                          press: () {
                            _loginController.validateAndSubmit();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Obx(() => Offstage(
              offstage: !_loginController.isLoading.value,
              child: const AppThemedLoader()))
        ],
      ),
    );
  }

  Widget getTabSignInScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 50),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "images/logo-rec.png",
                    width: 250,
                  ),
                  const Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _loginController.emailLoginForm,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        const SizedBox(height: 30),
                        buildPasswordFormField(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Obx(() => Checkbox(
                                  value: _loginController.rememberMe.value,
                                  activeColor: kPrimaryColor,
                                  onChanged: (value) {
                                    _loginController.rememberMe.value = value!;
                                  },
                                )),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: "Login",
                          press: () {
                            _loginController.validateAndSubmit();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Obx(() => Offstage(
              offstage: !_loginController.isLoading.value,
              child: const AppThemedLoader()))
        ],
      ),
    );
  }

  Widget getDesktopSignInScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    "images/logo-rec.png",
                    width: 300,
                  ),
                  const Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _loginController.emailLoginForm,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        const SizedBox(height: 30),
                        buildPasswordFormField(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Obx(() => Checkbox(
                                  value: _loginController.rememberMe.value,
                                  activeColor: kPrimaryColor,
                                  onChanged: (value) {
                                    _loginController.rememberMe.value = value!;
                                  },
                                )),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgotPasswordScreen());
                              },
                              child: const Text(
                                "Forgot Password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: "Login",
                          press: () {
                            _loginController.validateAndSubmit();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Obx(() => Offstage(
              offstage: !_loginController.isLoading.value,
              child: const AppThemedLoader()))
        ],
      ),
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
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
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
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }
}
