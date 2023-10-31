import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products", style: headingStyle),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Expanded(child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,),
              itemCount: demoProducts.length,
              itemBuilder: (BuildContext context , int index){
                return AllProductCard(product: demoProducts[index]);
              }),),
        ],
      ),

    );
  }
}

class AllProductCard extends StatelessWidget {
  const AllProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.1,
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: getProportionateScreenHeight(80),
                      width: getProportionateScreenWidth(140),
                      child: Image.asset(product.images[0],
                        fit: BoxFit.contain,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      product.title,
                      style: const TextStyle(color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13),
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          SizedBox(
            height: getProportionateScreenHeight(10),
          )
        ],
      ),
    );}
}