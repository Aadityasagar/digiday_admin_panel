import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

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
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopProductsScreen(),
                  smallScreen: getMobileProductsScreen(context),
                  mediumScreen: getTabProductsScreen(context),
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

Widget getMobileProductsScreen(BuildContext context) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Products",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            productProvider.productsList.isNotEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child:
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                },
                children: [
                  const TableRow(
                      decoration: BoxDecoration(color: kPrimaryColor),
                      children: [

                        /// s.no

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "S.No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// image

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// title

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Title",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// price

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// action

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Action",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                  ...productProvider.productsList.asMap().entries.map(
                        (products) {
                      return TableRow(
                          decoration:
                          const BoxDecoration(color: Colors.white),
                          children: [

                            /// s.no

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${products.key + 1}",
                                ),
                              ),
                            ),

                            /// image

                            Center(
                              child: products.value?.productImage==null ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("images/ProfileImage.png"),
                              ):
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.network(products.value?.productImage??"")
                              ),
                            ),

                            /// title

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(products.value.productTitle??"",
                                maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),

                            /// price

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${"₹"}${products.value.productSalePrice ?? ""}",
                                ),
                              ),
                            ),

                            /// action

                            Center(
                              child: IconButton(onPressed: (){
                                productProvider.selectedProduct=products.value;
                                Navigator.of(context).pushReplacementNamed(Routes.productDetailsScreen);
                              },
                                icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                            ),
                          ]);
                    },
                  )
                ],
              ),
            )
                : const Center(
              child: Text('No Products Added'),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getTabProductsScreen(BuildContext context) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Products",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: productProvider.productsList.isNotEmpty
                  ? Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                },
                children: [
                  const TableRow(
                      decoration: BoxDecoration(color: kPrimaryColor),
                      children: [
                        /// s.no

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "S.No",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// image

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// title

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Title",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// price

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// action

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Action",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                  ...productProvider.productsList.asMap().entries.map(
                        (products) {
                      return TableRow(
                          decoration:
                          const BoxDecoration(color: Colors.white),
                          children: [

                            /// s.no

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${products.key + 1}",
                                ),
                              ),
                            ),

                            /// image

                            Center(
                              child: products.value?.productImage==null ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("images/ProfileImage.png"),
                              ):
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(products.value?.productImage??"")
                              ),
                            ),

                            /// title

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(products.value.productTitle??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),

                            /// price

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${"₹"}${products.value.productSalePrice ?? ""}",
                                ),
                              ),
                            ),

                            /// action

                            Center(
                              child: IconButton(onPressed: (){
                                productProvider.selectedProduct=products.value;
                                Navigator.of(context).pushReplacementNamed(Routes.productDetailsScreen);
                              },
                                icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                            ),
                          ]);
                    },
                  )
                ],
              )
                  : const Center(
                child: Text('No products Added'),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopProductsScreen() {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Products",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 23,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (productProvider.productsList.isNotEmpty) Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(),
                                4: FlexColumnWidth(),
                              },
                              children: [
                                const TableRow(
                                    decoration: BoxDecoration(color: kPrimaryColor),
                                    children: [
                                      /// s.no

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "S.No",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      /// image

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Image",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      /// title

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Title",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      /// price

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      /// action

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Action",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]),
                                ...productProvider.productsList.asMap().entries.map(
                                      (products) {
                                    return TableRow(
                                        decoration:
                                        const BoxDecoration(color: Colors.white),
                                        children: [

                                          /// s.no

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                "${products.key + 1}",
                                              ),
                                            ),
                                          ),

                                          /// image

                                          Center(
                                            child: products.value?.productImage==null ? Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image.asset("images/ProfileImage.png"),
                                            ):
                                            Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Image.network(products.value?.productImage??"", height: 80,)
                                            ),
                                          ),

                                          /// title

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(products.value.productTitle??"",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),

                                          /// price

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                "${"₹"}${products.value.productSalePrice ?? ""}",
                                              ),
                                            ),
                                          ),

                                          /// action

                                          Center(
                                            child: IconButton(onPressed: (){
                                             productProvider.selectedProduct=products.value;
                                             Navigator.of(context).pushReplacementNamed(Routes.productDetailsScreen);

                                            },
                                            icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                          ),
                                        ]);
                                  },
                                )
                              ],
                            ) else const Center(
                              child: NoDataView(),
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  });
}