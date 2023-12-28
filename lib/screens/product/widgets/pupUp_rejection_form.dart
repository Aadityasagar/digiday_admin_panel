
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RejectionPopUpForm extends StatelessWidget {
  String productId;


    RejectionPopUpForm({super.key,
     required this.productId
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, productsProvider, child) {


        TextFormField buildRejectionReasonFormField() {
          return TextFormField(
            controller: productsProvider.rejectionReason,
            validator: (value) {
              if (value!.isEmpty) {
                return kPassNullError;
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Rejection Reason",
              hintText: "Enter rejection reason",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          );
        }



        return AlertDialog(
          title: Text('Reason For Rejection'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add your form fields here
                       Form(
                         key: productsProvider.rejectionReasonFormKey,
                         child: Column(
                          children: [
                             const SizedBox(height: 15),
                             buildRejectionReasonFormField(),
                            const SizedBox(height: 15),

                            DefaultButton(
                              press: ()async{

                               await productsProvider.validateAndSubmitReason(productId);

                              String rejected="Rejected";
                               productsProvider.verifyProduct(productId, rejected);

                               Navigator.pop(context); // Close the popup
                              },
                              text: 'Submit',
                            ),

                            ],
                         ),)
                       ],
                    )
                 );
      }
    );
  }



}
