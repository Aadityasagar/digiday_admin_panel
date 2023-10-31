import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/auth/controllers/register_controller.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDetailsScreen extends StatelessWidget {
  final RegistrationController _registrationController=Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Business Details", style: headingStyle),
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Complete your details",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.06),
                      getForm(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        "By continuing you confirm that you agree \nwith our Term and Condition",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() =>  Offstage(
            offstage: !_registrationController.isLoading.value,
            child:const AppThemedLoader()))
      ],
    );
  }

  Widget getForm() {
    return Form(
      key: _registrationController.formBusiness,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBusinessNameFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBusinessAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBusinessCityFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBusinessStateFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildBusinessPincodeFormField(),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Register",
            press: () {
              if (_registrationController.formBusiness.currentState!.validate()) {
                //Navigator.pushNamed(context, OtpScreen.routeName);
                _registrationController.validateAndRegister();
              }
             // Navigator.pushNamed(context, OtpScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildBusinessAddressFormField() {
    return TextFormField(
      controller: _registrationController.business_address,
      validator: (value) {
        if (value!.isEmpty) {
          return kAddressNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBusinessCityFormField() {
    return TextFormField(
     controller: _registrationController.business_city,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "City",
        hintText: "Enter your city name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBusinessStateFormField() {
    return TextFormField(
     controller: _registrationController.business_state,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "State",
        hintText: "Enter your state name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBusinessPincodeFormField() {
    return TextFormField(
     controller: _registrationController.business_pincode,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Pincode",
        hintText: "Enter your pincode",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildBusinessNameFormField() {
    return TextFormField(
      controller: _registrationController.business_name,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Business Name",
        hintText: "Enter your Business name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
