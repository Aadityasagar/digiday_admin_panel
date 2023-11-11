import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/business/controllers/business_controller.dart';
import 'package:digiday_admin_panel/utils/services/city_service.dart';
import 'package:digiday_admin_panel/utils/services/state_service.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../size_config.dart';

class AddBusiness extends StatelessWidget {
   AddBusiness({Key? key}) : super(key: key);

  final BusinessController _businessController=Get.find<BusinessController>();

   TextFormField buildNameFormField() {
     return TextFormField(
       keyboardType: TextInputType.text,
       controller: _businessController.businessName,
       validator: (value) {
         if (value!.isEmpty) {
           return "Business Name can't be empty!";
         }
         return null;
       },
       decoration: const InputDecoration(
         labelText: "Business Name",
         hintText: "Enter business name",
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
       controller: _businessController.phone,
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
         hintText: "Enter business phone number",
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
       controller: _businessController.email,
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
         hintText: "Enter business email",
         floatingLabelBehavior: FloatingLabelBehavior.always,
         suffixIcon: Icon(Icons.mail),
       ),
     );
   }

   TextFormField buildAddressFormField() {
     return TextFormField(
       keyboardType: TextInputType.text,
       controller: _businessController.addressController,
       validator: (value) {
         if (value!.isEmpty) {
           return "Address can't be empty";
         }
         return null;
       },
       decoration: const InputDecoration(
         labelText: "Address",
         hintText: "Enter business address",
         floatingLabelBehavior: FloatingLabelBehavior.always,
         suffixIcon: Icon(Icons.pin_drop_outlined),
       ),
     );
   }

   TextFormField buildPincodeFormField() {
     return TextFormField(
       keyboardType: TextInputType.number,
       controller: _businessController.pincodeController,
       validator: (value) {
         if (value!.isEmpty) {
           return "PinCode can't be empty";
         }
         return null;
       },
       decoration: const InputDecoration(
         labelText: "PinCode",
         hintText: "Enter business area pin-code",
         floatingLabelBehavior: FloatingLabelBehavior.always,
         suffixIcon: Icon(Icons.pin),
       ),
     );
   }

   EasyAutocomplete buildCityFormField() {
     return EasyAutocomplete(
         suggestions: CitiesService.cities,
         cursorColor: Colors.blue,
         controller: _businessController.cityController,
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
         validator: (value) => _businessController.cityFieldValidator(value),
     );
   }

   EasyAutocomplete buildStateFormField() {
     return EasyAutocomplete(
         suggestions: StatesService.states,
         cursorColor: Colors.blue,
         controller: _businessController.stateController,
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
         validator: (value) => _businessController.stateFieldValidator(value),
     );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Business", style: headingStyle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Enter Complete business details",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Form(
                key: _businessController.addBusinessFormKey,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildPhoneFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    // buildEmailFormField(),
                    // SizedBox(height: getProportionateScreenHeight(15)),

                    buildAddressFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildCityFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildStateFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildPincodeFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    // buildCityFormField(context),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    DefaultButton(
                      text: "Continue",
                      press: () => _businessController.validateAndSubmit(),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}


// SizedBox(height: getProportionateScreenHeight(15)),
// DefaultButton(
// text: "Add Images",
// press: (){
// selectImages();
// },
// ),
// SizedBox(height: getProportionateScreenHeight(15)),
// Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
// color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
// height: 200, width: 350,
// child: GridView.builder(
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
// itemCount: imageList.length,
// itemBuilder: (BuildContext context, int index){
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child:  Container(child: Image.file(File(imageList[index].path), fit: BoxFit.cover,),
// ),
// );
// })
// ),



