import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/screens/product/product_details_screen.dart';
import 'package:digiday_admin_panel/screens/product/widgets/pupUp_rejection_form.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                backgroundColor:  ColourScheme.backgroundColor,
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
            const SizedBox(
              height: 10,
            ),
          SizedBox(
              child: Expanded(
                  child: getTabView()
              )
            )
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                child: Expanded(
                    child: getTabView()
                )
            )
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
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// blank space

                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: getTabView()
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}

Widget getTabView(){
  return Consumer<ProductsProvider>(
    builder: (context, productProvider, child) {
      return DefaultTabController(
        length: productProvider.pageTabs.length,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
                tabs: productProvider.pageTabs,
                labelColor: Colors.black),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child:
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1),
                },
                children: [
                  const TableRow(
                      decoration: BoxDecoration(color: kPrimaryColor),
                      children: [

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

                          /// verify product


                          // Center(
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(vertical: 10),
                          //     child: Text(
                          //       "Approve/Reject",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.white),
                          //     ),
                          //   ),
                          // ),

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
                    ...productProvider.allProductsList.asMap().entries.map(
                          (products) {
                        return TableRow(
                            decoration:
                            const BoxDecoration(color: Colors.white),
                            children: [

                            /// image

                            Center(
                              child: products.value?.productImage==null ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("assets/images/ProfileImage.png", height: 60,),
                              ):
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.network(products.value?.productImage??"", height: 60,)
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

                              ///verify products


                              // Center(
                              //     child: Padding(
                              //         padding: const EdgeInsets.symmetric(vertical: 15.0),
                              //         child:  Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //           children: [
                              //             MaterialButton(onPressed: (){
                              //
                              //               String verified= "Verified";
                              //               if(products.value!=null) {
                              //                 productProvider.verifyProduct(products.value.id!, verified);
                              //                 productProvider.allProductsList.remove(products.value);
                              //                 productProvider.approvedProductsList.add(products.value);
                              //               }
                              //
                              //             },
                              //                 color: Colors.green,
                              //                 child: const Text('Approve',
                              //                   style: TextStyle(
                              //                       color: Colors.white
                              //                   ),)),
                              //
                              //             MaterialButton(onPressed: (){
                              //
                              //               showDialog(
                              //                 context: context,
                              //                 builder: (context) => RejectionPopUpForm(productId: products.value.id!,),
                              //               );
                              //
                              //               productProvider.allProductsList.remove(products.value);
                              //               productProvider.rejectedProductsList.add(products.value);
                              //
                              //             },
                              //               color: Colors.red,
                              //               child: const Text('Reject',
                              //                 style: TextStyle(
                              //                     color: Colors.white
                              //                 ),),),
                              //           ],
                              //         )
                              //     )
                              // ),

                              /// action

                              Center(
                                child: IconButton(onPressed: (){
                                  // productProvider.selectedProduct=products.value;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(selectedProduct: products.value)),
                                  );

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
        ),
      );
    }
  );
}

Widget approvedProducts(){
  return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (productProvider.approvedProductsList.isNotEmpty) Table(
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

                            /// verify product


                            // Center(
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(vertical: 10),
                            //     child: Text(
                            //       "Approve/Reject",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.white),
                            //     ),
                            //   ),
                            // ),

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
                      ...productProvider.approvedProductsList.asMap().entries.map(
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
                                child: Image.asset("assets/images/ProfileImage.png"),
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

                                ///verify products


                                // Center(
                                //     child: Padding(
                                //         padding: const EdgeInsets.symmetric(vertical: 15.0),
                                //         child:  Material(
                                //           elevation: 3,
                                //           child: Container(
                                //             color: Colors.green,
                                //               child: const Padding(
                                //                 padding: EdgeInsets.all(5.0),
                                //                 child: Text('Approved',
                                //                 style: TextStyle(
                                //                   color: Colors.white
                                //                 ),),
                                //               )),
                                //         )
                                //     )
                                // ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: (){
                                    // productProvider.selectedProduct=products.value;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(selectedProduct: products.value)),
                                    );

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
          ),
        );
      }
  );
}

Widget rejectedProducts(){
  return Consumer<ProductsProvider>(
      builder: (context, productProvider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (productProvider.rejectedProductsList.isNotEmpty) Table(
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

                            /// verify product


                            // Center(
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(vertical: 10),
                            //     child: Text(
                            //       "Approve/Reject",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.white),
                            //     ),
                            //   ),
                            // ),

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
                      ...productProvider.rejectedProductsList.asMap().entries.map(
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
                                              child: Image.asset("assets/images/ProfileImage.png"),
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

                                ///verify products


                                // Center(
                                //     child: Padding(
                                //         padding: const EdgeInsets.symmetric(vertical: 15.0),
                                //         child:  Material(
                                //           elevation: 3,
                                //           child: Container(
                                //               color: Colors.red,
                                //               child: const Padding(
                                //                 padding: EdgeInsets.all(5.0),
                                //                 child: Text('Rejected',
                                //                   style: TextStyle(
                                //                       color: Colors.white
                                //                   ),),
                                //               )),
                                //         )
                                //     )
                                // ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: (){
                                    // productProvider.selectedProduct=products.value;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(selectedProduct: products.value)),
                                    );

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
          ),
        );
      }
  );
}