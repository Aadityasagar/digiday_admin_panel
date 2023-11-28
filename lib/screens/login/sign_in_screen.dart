import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/account_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {

  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  bool isPasswordIcon1 = false;
  bool isObscure1 = true;

  bool isLoading = false;
  bool rememberMe = false;
  bool alreadyUser = false;


  final GlobalKey<FormState> emailLoginForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController email=TextEditingController(text: "hireaxia@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "User@1234567");



  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            child: ResponsiveWidget(
              largeScreen: getDesktopSignInScreen(context),
              mediumScreen: getTabSignInScreen(context),
              smallScreen: getMobileSignInScreen(context),
            ),
          ),
        ),
        Offstage(
            offstage: !isLoading,
            child: const AppThemedLoader())
      ],
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
                    key: emailLoginForm,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        const SizedBox(height: 30),
                        buildPasswordFormField(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                rememberMe = value!;
                              },
                            ),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {

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
                          press: ()=>onSubmit(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
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
                    key: emailLoginForm,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        const SizedBox(height: 30),
                        buildPasswordFormField(),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                rememberMe = value!;
                              },
                            ),
                            const Text("Remember me"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {

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
                          press: ()=>onSubmit(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDesktopSignInScreen(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 100),
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
                      key: emailLoginForm,
                      child: Column(
                        children: [
                          buildEmailFormField(),
                          const SizedBox(height: 30),
                          buildPasswordFormField(),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  rememberMe = value!;
                                },
                              ),
                              const Text("Remember me"),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {

                                },
                                child: const Expanded(
                                  child:  Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: DefaultButton(
                              text: "Login",
                              press: ()=>onSubmit(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
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
      controller: email,
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


  Future<void> onSubmit()async{
    final authProvider = Provider.of<AccountProvider>(context,listen: false);
    if (emailLoginForm.currentState!.validate()) {
      FocusScope.of(context).unfocus(); //to hide the keyboard - if any

      bool status = await authProvider.signInWithEmailAndPassword(
          email.text,
          passwordController.text);

      if (!status) {
        final snackBar = SnackBar(
          content: Text('Error while login!'),
          duration: Duration(seconds: 3), // Optional duration
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Perform some action when the action button is pressed
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }
    }
  }
}
