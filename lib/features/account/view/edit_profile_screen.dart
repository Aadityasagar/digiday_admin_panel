import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/account/controller/edit_profile_controller.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:digiday_admin_panel/utils/services/city_service.dart';
import 'package:digiday_admin_panel/utils/services/state_service.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/profile_pic.dart';


class EditProfileScreen extends StatelessWidget {

  final EditProfileController _editProfileController=Get.put(EditProfileController());


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text("Edit Profile", style: headingStyle),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: getProportionateScreenHeight(20)),
                        ProfilePic(),
                        const SizedBox(height: 20),
                        const Text(
                          "Edit your personal details",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.1),
                        getEditProfileForm(context),
                        SizedBox(height: getProportionateScreenHeight(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Obx(() =>  Offstage(
            offstage: !_editProfileController.isLoading.value,
            child: const AppThemedLoader()))
      ],
    );
  }

 Widget getEditProfileForm(context) {
    return Form(
      key: _editProfileController.prifileform,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildStateFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPincodeFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: "Submit",
            press: () {
          _editProfileController.validateAndSubmit();

               },
          ),
        ],
      ),
    );
  }




  TextFormField buildFirstNameFormField() {
    return TextFormField(
     controller: _editProfileController.firstName,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
    controller: _editProfileController.lastName,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _editProfileController.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return kPhoneNullError;
        } else if (!phoneValidatorRegExp.hasMatch(value)) {
         return kInvalidPhoneError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _editProfileController.email,
      readOnly: true,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _editProfileController.addressController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Address can't be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.pin_drop_outlined),
      ),
    );
  }

  TextFormField buildPincodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _editProfileController.pincodeController,
      validator: (value) {
        if (value!.isEmpty) {
          return "PinCode can't be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "PinCode",
        hintText: "Enter your area pin-code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.pin),
      ),
    );
  }

  EasyAutocomplete buildCityFormField() {
    return EasyAutocomplete(
        suggestions: CitiesService.cities,
        cursorColor: Colors.blue,
         controller: _editProfileController.cityController,
        decoration: const InputDecoration(
          labelText: "City",
          hintText: "Select your city",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.location_city),
        ),
        suggestionBuilder: (data) {
          return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                  data,
                  style: const TextStyle(
                      color: Colors.black
                  )
              )
          );
        },
        validator: (value) => _editProfileController.cityFieldValidator(value),
        onChanged: (value){
          //_editProfileController.cityController.text=value;
        }
    );
  }

  EasyAutocomplete buildStateFormField() {
    return EasyAutocomplete(
        suggestions: StatesService.states,
        cursorColor: Colors.blue,
        controller: _editProfileController.stateController,
        decoration: const InputDecoration(
          labelText: "State",
          hintText: "Select your state",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.map),
        ),
        suggestionBuilder: (data) {
          return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                  data,
                  style: const TextStyle(
                      color: Colors.black
                  )
              )
          );
        },
        validator: (value) => _editProfileController.stateFieldValidator(value),
        onChanged: (value){
          //_editProfileController.stateController.text=value;
        }
    );
  }
}
