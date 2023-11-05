import 'dart:html';

import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/features/products/controller/products_controller.dart';
import 'package:digiday_admin_panel/utils/services/network/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/product_model.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Products", style: headingStyle),
      ),

      body:  Obx( ()=> SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: _productController.products.length,
                        itemBuilder: (BuildContext context, int index) {

                          return ProductCard(
                              product: _productController.products[index]);
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }



}



class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 150,
    this.height = 240,
    this.aspectRatio = 1.0,
    required this.product,
  }) : super(key: key);

  final double width;
  final double height,
      aspectRatio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Container(
            width: width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                  width: 200,
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Hero(
                      tag: UniqueKey(),
                      child:  FutureBuilder(
                        future: FirebaseService.getImageUrl("${ApiUrl.productPicFolder}/${product.productImage}"),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text(
                              "Something went wrong",
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Image.network(
                              snapshot.data.toString(),
                              fit: BoxFit.cover,
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ),


                Text(
                  product.productTitle??"",
                  style: const TextStyle(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\₹${product.productSalePrice}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // InkWell(
                    //   borderRadius: BorderRadius.circular(50),
                    //   onTap: () {},
                    //   child: Container(
                    //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                    //     height: getProportionateScreenWidth(28),
                    //     width: getProportionateScreenWidth(28),
                    //     decoration: BoxDecoration(
                    //       color: product.isFavourite
                    //           ? kPrimaryColor.withOpacity(0.15)
                    //           : kSecondaryColor.withOpacity(0.1),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: SvgPicture.asset(
                    //       "assets/icons/Heart Icon_2.svg",
                    //       color: product.isFavourite
                    //           ? Color(0xFFFF4848)
                    //           : Color(0xFFDBDEE4),
                    //     ),
                    //   ),
                    // ),
                  ],
                )

              ],
            ),
          ),
        ),

      ),
    );
  }
}
