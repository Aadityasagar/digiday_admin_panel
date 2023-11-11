import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/features/offers/controller/offer_controller.dart';
import 'package:digiday_admin_panel/features/offers/data/offer_model.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferDetailsCard extends StatelessWidget {
   const OfferDetailsCard({
    Key? key,
    required this.offerData
  }) : super(key: key);

  final Offer offerData;


  @override
  Widget build(BuildContext context) {
    OfferController _offerController=Get.find<OfferController>();
    return Padding(
      padding: EdgeInsets.all( getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(242),
        height: getProportionateScreenWidth(180),
        child: SingleChildScrollView(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(color: Colors.grey.shade700,
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w800,),
                "${offerData.offerTitle}",),
              SizedBox(height: getProportionateScreenWidth(15),),
              Text(
                style: TextStyle(color: Colors.grey.shade700,
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w700,),
                "Discount Value",),
              Text(
                style: TextStyle(color: Colors.grey.shade600,
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w600,),
                "${offerData.discountAmount}",),
              SizedBox(height: getProportionateScreenWidth(15),),
              Text(
                style: TextStyle(color: Colors.grey.shade700,
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w700,),
                "Offer Type",),
              Text(
                style: TextStyle(color: Colors.grey.shade600,fontSize: getProportionateScreenWidth(18),
                ),
                "${offerData.offerType}",),
              SizedBox(height: getProportionateScreenWidth(15),),
              Text(
                style: TextStyle(color: Colors.grey.shade700,
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w700,),
                "Description",),
              Text(
                style: TextStyle(color: Colors.grey.shade600,fontSize: getProportionateScreenWidth(15),
                ),
                "${offerData.description}",),
              SizedBox(height: getProportionateScreenWidth(20),),


              DefaultButton(
                text: "Edit",
                press: () {
                  _offerController.navigateToEditScreen(offerData);
                },
              ),
              SizedBox(height: getProportionateScreenWidth(20),),
              DefaultButton(
                text: "Delete",
                press: () {
                  _offerController.deleteBusinessOffer(offerData.id!);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}