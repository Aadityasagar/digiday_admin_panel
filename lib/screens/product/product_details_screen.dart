import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/screens/product/widgets/product_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/services/network/firebase_service.dart';
class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<ProductsProvider>(
        builder: (context,productProvider,child) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor:  ColourScheme.backgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: const ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopProductsDetailsScreen(),
                  smallScreen: getMobileProductsDetailsScreen(context),
                  mediumScreen: getTabProductsDetailsScreen(context),
                ),
              ),
              Offstage(
                  offstage: !productProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}


Widget getMobileProductsDetailsScreen(BuildContext context) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return productProvider.selectedProduct!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            /// image

            Container(height: 300,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Center(
                  child: productProvider.selectedProduct?.productImage==null ?
                  Image.asset("images/ProfileImage.png", height: 300, width: 300,):
                  Image.network(productProvider.selectedProduct?.productImage??"", height: 300, width: 300,),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [

                  /// category

                  Text(
                    productProvider.selectedProduct?.productCategory ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// title

                  Text(
                    productProvider.selectedProduct?.productTitle ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/25,
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),

                  /// brand

                  Text(
                    productProvider.selectedProduct?.productBrand ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/40, fontWeight: FontWeight.w400,),
                  ),

                  /// price

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        /// sale price

                        Row(
                          children: [
                            Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(width: 5),

                            Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                  fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
                        ),

                        /// regular price

                        Row(
                          children: [
                            Text("Regular price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(width: 5),

                            Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                  fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
                        ),
                      ],),
                  ),
                ],),
              ),
            ),

            const SizedBox(height: 10,),
            /// description

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                          fontWeight: FontWeight.w600,)
                    ),
                    const SizedBox(width: 10,),

                    Flexible(
                      child: Text(
                        productProvider.selectedProduct?.productDescription ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                        maxLines: 100,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ):const Text("No Product selected!");
  });
}

Widget getTabProductsDetailsScreen(BuildContext context) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return productProvider.selectedProduct!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            /// image

            Container(height: 300,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Center(
                  child: productProvider.selectedProduct?.productImage==null ?
                  Image.asset("images/ProfileImage.png", height: 300, width: 300,):
                  Image.network(productProvider.selectedProduct?.productImage??"", height: 300, width: 300,),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [

                  /// category

                  Text(
                    productProvider.selectedProduct?.productCategory ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// title

                  Text(
                    productProvider.selectedProduct?.productTitle ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/30,
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),

                  /// brand

                  Text(
                    productProvider.selectedProduct?.productBrand ?? "",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/60, fontWeight: FontWeight.w400,),
                  ),

                  /// price

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        /// sale price

                        Row(
                          children: [
                            Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(width: 5),

                            Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
                        ),

                        /// regular price

                        Row(
                          children: [
                            Text("Regular price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                fontWeight: FontWeight.w600),
                            ),

                            const SizedBox(width: 5),

                            Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ],
                        ),
                      ],),
                  ),
                ],),
              ),
            ),

            const SizedBox(height: 10,),
            /// description

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                          fontWeight: FontWeight.w600,)
                    ),
                    const SizedBox(width: 10,),

                    Flexible(
                      child: Text(
                        productProvider.selectedProduct?.productDescription ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                        maxLines: 100,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ):const Text("No Product selected!");
  });
}

Widget getDesktopProductsDetailsScreen() {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return productProvider.selectedProduct!=null? SingleChildScrollView(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// blank space
          SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height,
            child: const SideBarMenu(),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      /// image container

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(height: 350,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                            child: Center(
                              child: productProvider.selectedProduct?.productImage==null ?
                              Image.asset("images/ProfileImage.png", height: 400, width: 400,):
                              Image.network(productProvider.selectedProduct?.productImage??"", height: 400, width: 400,),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      Flexible(
                        child: Column(
                          children: [
                            Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(children: [

                                  /// category

                                  Text(
                                    productProvider.selectedProduct?.productCategory ?? "",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                      fontWeight: FontWeight.w600),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  /// title

                                  Text(
                                    productProvider.selectedProduct?.productTitle ?? "",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/60,
                                      fontWeight: FontWeight.w600, color: Colors.black),
                                  ),

                                  /// brand

                                  Text(
                                    productProvider.selectedProduct?.productBrand ?? "",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/110, fontWeight: FontWeight.w400,),
                                  ),

                                  /// price

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        /// sale price

                                        Row(
                                          children: [
                                            Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                fontWeight: FontWeight.w600),
                                            ),

                                            const SizedBox(width: 5),

                                            Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                  fontWeight: FontWeight.w400, color: Colors.black),
                                            ),
                                          ],
                                        ),

                                        /// regular price

                                        Row(
                                          children: [
                                            Text("Regular price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                fontWeight: FontWeight.w600),
                                            ),

                                            const SizedBox(width: 5),

                                            Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",
                                              style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                  fontWeight: FontWeight.w400, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],),
                                  ),
                                ],),
                              ),
                            ),

                            const SizedBox(height: 20,),
                            /// description

                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                              child:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Description",
                                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600,)
                                    ),
                                    const SizedBox(width: 10,),

                                    Flexible(
                                      child: Text(
                                        productProvider.selectedProduct?.productDescription ?? "",
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                            fontWeight: FontWeight.w400,
                                        color: Colors.black
                                        ),
                                        maxLines: 100,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ],
      ),
    ):const Text("No Product selected!");
  });
}


