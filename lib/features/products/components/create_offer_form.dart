import 'dart:io';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../size_config.dart';


class CreateOfferForm extends StatefulWidget {
  const CreateOfferForm({super.key});

  @override
  _CreateOfferFormState createState() => _CreateOfferFormState();
}

class _CreateOfferFormState extends State<CreateOfferForm> {

  final ImagePicker offerBannerPicker = ImagePicker();
  List<XFile> bannerList= [];
  void selectImages() async{
    final List<XFile>? selectedimages = await offerBannerPicker.pickMultiImage();
    if (selectedimages!.isNotEmpty){
      bannerList.addAll(selectedimages);
    }
    setState(() {

    });
  }

  final _offerFormKey = GlobalKey<FormState>();
  String? discount;
  String? category;
  String? couponCode;
  String? termsandconditions;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _offerFormKey,
      child: Column(
        children: [
          buildDiscountFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildCategoryFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildTermsAndConditionsFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildCouponCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: "Add Offer Banner",
            press: (){
              selectImages();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
              color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
              width: getProportionateScreenWidth(350),
              height: getProportionateScreenWidth(100),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: bannerList.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Image.file(File(bannerList[index].path), fit: BoxFit.cover,),
                      ),
                    );
                  })
          ),
          SizedBox(height: getProportionateScreenHeight(35)),
          DefaultButton(
            text: "Create Now",
            press: () {
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              //   // if all are valid then go to success screen
              //   Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              // }

              //Navigator.pushNamed(context, BusinessDetailsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildDiscountFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => discount = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.isNotEmpty && password == conform_password) {
      //     removeError(error: kMatchPassError);
      //   }
      //   conform_password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if ((password != value)) {
      //     addError(error: kMatchPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Discount",
        hintText: "Enter discount",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCategoryFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => category = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.isNotEmpty && password == conform_password) {
      //     removeError(error: kMatchPassError);
      //   }
      //   conform_password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if ((password != value)) {
      //     addError(error: kMatchPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Product Category",
        hintText: "Enter product category",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildTermsAndConditionsFormField() {
    return TextFormField(
      onSaved: (newValue) => termsandconditions = newValue,
      minLines: 6,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.isNotEmpty && password == conform_password) {
      //     removeError(error: kMatchPassError);
      //   }
      //   conform_password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if ((password != value)) {
      //     addError(error: kMatchPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Terms & Conditions",
        hintText: "Enter terms & conditions",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCouponCodeFormField() {
    return TextFormField(
      onSaved: (newValue) => couponCode = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.isNotEmpty && password == conform_password) {
      //     removeError(error: kMatchPassError);
      //   }
      //   conform_password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if ((password != value)) {
      //     addError(error: kMatchPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: const InputDecoration(
        labelText: "Coupon Code",
        hintText: "Create coupon code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }





}


