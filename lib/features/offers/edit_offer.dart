import 'dart:io';

import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/features/business/controllers/business_controller.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/features/offers/controller/offer_controller.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../size_config.dart';

class EditOffer extends StatefulWidget {
  const EditOffer({Key? key}) : super(key: key);

  @override
  State<EditOffer> createState() => _EditOfferState();
}

class _EditOfferState extends State<EditOffer> {
  OfferController _offerController = Get.find<OfferController>();
  final BusinessController _businessController = Get.find<BusinessController>();

  TextFormField buildOfferNameFormField() {
    return TextFormField(
      controller: _offerController.offerTitle,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Offer title can't be empty!";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Offer Title",
        hintText: "Enter Offer title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildOfferDescriptionFormField() {
    return TextFormField(
      controller: _offerController.description,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 6,
      validator: (value) {
        if (value!.isEmpty) {
          return "Description can't be empty!";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Offer Description",
        hintText: "Enter offer Description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildOfferAmountFormField() {
    return TextFormField(
      controller: _offerController.discountAmount,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "Offer discount amount can't be empty!";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Offer Discount",
        hintText: "Enter discount amount",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  EasyAutocomplete buildOfferTypeFormField() {
    return EasyAutocomplete(
        suggestions: _offerController.offerTypes,
        cursorColor: Colors.blue,
        controller: _offerController.offerType,
        decoration: const InputDecoration(
          labelText: "Offer Type",
          hintText: "Select offer type",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.type_specimen),
        ),
        suggestionBuilder: (data) {
          return Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(data, style: const TextStyle(color: Colors.black)));
        },
        validator: (value) => _offerController.offerTypeValidator(value),
        onChanged: (value) {
          //_editProfileController.stateController.text=value;
        });
  }

  TextFormField buildOfferCodeFormField() {
    return TextFormField(
      controller: _offerController.offerCode,
      keyboardType: TextInputType.text,
      readOnly: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Offer code can't be empty!";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Offer Code",
        hintText: "Enter offer code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text("Edit offer", style: headingStyle),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Enter Complete offer details",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Obx(() => Form(
                        key: _offerController.updateOfferFormKey,
                        child: Column(
                          children: [
                            buildOfferNameFormField(),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            buildOfferDescriptionFormField(),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            buildOfferAmountFormField(),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            buildOfferTypeFormField(),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            buildOfferCodeFormField(),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            (_offerController.selectedImage?.value != "" ||
                                        _offerController.selectedOffer !=
                                            null) &&
                                    _offerController.selectedImage?.value !=
                                        null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade700)),
                                    height: 200,
                                    width: 350,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: _offerController
                                                      .selectedImage!.value !=
                                                  ""
                                              ? Image.file(
                                                  File(_offerController
                                                      .selectedImage!.value!),
                                                  fit: BoxFit.cover,
                                                )
                                              : FutureBuilder(
                                                  future: FirebaseService
                                                      .getImageUrl(
                                                          "${ApiUrl.offerBannersFolder}/${_offerController.selectedOffer!.offerBanner!}"),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text(
                                                        "Something went wrong",
                                                      );
                                                    }
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          snapshot.data
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    }
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                )),
                                    ))
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: DefaultButton(
                                text: _offerController.selectedImage?.value !=
                                            "" ||
                                        _offerController.selectedImage?.value !=
                                            null
                                    ? "Change Image"
                                    : "Add Image",
                                press: () {
                                  _offerController.selectImages();
                                },
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(35)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DefaultButton(
                                text: "Continue",
                                press: () {
                                  if (_businessController
                                          ?.getBusinessData?.id !=
                                      null) {
                                    // _offerController.validateAndUpdate(_businessController.getBusinessData?.id??"");
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(35)),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        Obx(() => Offstage(
            offstage: !_offerController.isLoading.value,
            child: const AppThemedLoader()))
      ],
    );
  }
}
