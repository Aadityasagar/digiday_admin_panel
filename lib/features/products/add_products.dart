import 'dart:io';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';
import '../../size_config.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageList= [];

  void selectImages() async{
    final List<XFile>? selectedimages = await imagePicker.pickMultiImage();
    if (selectedimages!.isNotEmpty){
      imageList.addAll(selectedimages);
    }
    setState(() {
    });
  }

  final _AddProductformKey = GlobalKey<FormState>();
  String? productName;
  String? regularPrice;
  String? salePrice;
  String? description;
  String? brandName;
  String? category;


  TextFormField buildRegularPriceFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => regularPrice = newValue,
      decoration: InputDecoration(
        labelText: "Regular Price",
        hintText: "Enter Product Regular Price",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildSalePriceFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => salePrice = newValue,
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
      decoration: InputDecoration(
        labelText: "Sale Price",
        hintText: "Enter Product Sale Price",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildProductDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 6,
      onSaved: (newValue) => description = newValue,
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
      decoration: InputDecoration(
        labelText: "Product Description",
        hintText: "Enter Product Description",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildProductBrandFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => brandName = newValue,
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
      decoration: InputDecoration(
        labelText: "Product Brand Name",
        hintText: "Enter Product Brand Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildProductCategoryFormField() {
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
      decoration: InputDecoration(
        labelText: "Product Category",
        hintText: "Enter Product Category",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildProductNameFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => productName = newValue,
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
      decoration: InputDecoration(
        labelText: "Product Name",
        hintText: "Enter Product Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product", style: headingStyle),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [

              const Text(
                "Enter Complete product details",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),

              Form(
                key: _AddProductformKey,
                child: Column(
                  children: [
                    buildProductNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Row(
                      children: [
                        Container(
                          width: getProportionateScreenWidth(160),
                          child: buildRegularPriceFormField(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: getProportionateScreenWidth(160),
                          child: buildSalePriceFormField(),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildProductDescriptionFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildProductBrandFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    buildProductCategoryFormField(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    DefaultButton(
                      text: "Add Images",
                      press: (){
                        selectImages();
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
                        height: 200, width: 350,
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                            itemCount: imageList.length,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(child: Image.file(File(imageList[index].path), fit: BoxFit.cover,),

                                ),
                              );
                            })
                    ),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   // if all are valid then go to success screen
                        //   Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                        // }

                        // Navigator.pushNamed(context, BusinessDetailsScreen.routeName);
                      },
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
