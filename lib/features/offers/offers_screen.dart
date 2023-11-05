import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/offers/add_offer.dart';
import 'package:digiday_admin_panel/features/offers/components/offer_card_widget.dart';
import 'package:digiday_admin_panel/features/offers/controller/offer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final OfferController _offersController=Get.find<OfferController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Offers", style: headingStyle),
      ),

      body:  Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,
              horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child:  _offersController.offers.length!=0 ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _offersController.offers.length,
                    itemBuilder: (BuildContext context, int index) {

                      return OfferCard(
                        offerData: _offersController.offers[index],
                      );
                    }
                ): const Center(child: Text("No Offers!")),
              ),
            ],
          ),
        ),
      ),
bottomNavigationBar: Padding(
  padding: const EdgeInsets.symmetric(vertical: 50.0,
      horizontal: 50),
  child: DefaultButton(
    text: 'Create Offer',
    press: (){
      Get.to(const AddOffer());
    },
  ),
),
    );




  }

}




