import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// image

            AspectRatio(
              aspectRatio: 16/9,
              child: Center(
                child: productProvider.selectedProduct?.productImage==null ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset("images/ProfileImage.png"),
                ):
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.network(productProvider.selectedProduct?.productImage??"")
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// brand name

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productBrand ?? "",
                  ),
                ),


                /// title


                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productTitle ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),


                /// category

                Row(
                  children: [
                    const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        productProvider.selectedProduct?.productCategory ?? "",
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                /// price

                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    /// sale

                    Row(
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Sale Price", style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                          ),
                        ),
                      ],
                    ),

                    /// regular

                    Row(
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Regular Price", style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",)
                        ),
                      ],
                    ),

                  ],
                ),

                /// description

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    productProvider.selectedProduct?.productDescription ?? "",
                    maxLines: 100,
                    textAlign: TextAlign.justify,
                  ),
                ),


                /// flags

                Center(
                  child: Row(
                    children: [
                      InkWell(onTap: (){},
                          child: const Icon(Icons.flag, color: Colors.red,)),
                      InkWell(onTap: (){},
                          child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                    ],
                  ),
                )
              ],
            )
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// image

            Center(
              child: productProvider.selectedProduct?.productImage==null ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset("images/ProfileImage.png"),
              ):
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.network(productProvider.selectedProduct?.productImage??"", height: 400,)
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// brand name

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productBrand ?? "",
                  ),
                ),


                /// title


                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productTitle ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),


                /// category

                Row(
                  children: [
                    const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        productProvider.selectedProduct?.productCategory ?? "",
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                /// price

                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    /// sale

                    Row(
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Sale Price", style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                          ),
                        ),
                      ],
                    ),

                    /// regular

                    Row(
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Regular Price", style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",)
                        ),
                      ],
                    ),

                  ],
                ),

                /// description

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    productProvider.selectedProduct?.productDescription ?? "",
                    maxLines: 100,
                    textAlign: TextAlign.justify,
                  ),
                ),


                /// flags

                Center(
                  child: Row(
                    children: [
                      InkWell(onTap: (){},
                          child: const Icon(Icons.flag, color: Colors.red,)),
                      InkWell(onTap: (){},
                          child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ):const Text("No Product selected!");
  });
}

Widget getDesktopProductsDetailsScreen() {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return productProvider.selectedProduct!=null? SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
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
                        /// image

                        Center(
                          child: productProvider.selectedProduct?.productImage==null ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.asset("images/ProfileImage.png"),
                          ):
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.network(productProvider.selectedProduct?.productImage??"", height: 400,)
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// brand name

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                productProvider.selectedProduct?.productBrand ?? "",
                              ),
                            ),


                            /// title


                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                productProvider.selectedProduct?.productTitle ?? "",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),


                            /// category

                            Row(
                              children: [
                                const Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    productProvider.selectedProduct?.productCategory ?? "",
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            /// price

                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                /// sale

                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("Sale Price", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("${"₹"}${productProvider.selectedProduct?.productSalePrice ?? ""}",
                                      ),
                                    ),
                                  ],
                                ),

                                /// regular

                                Row(
                                  children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("Regular Price", style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("${"₹"}${productProvider.selectedProduct?.productRegularPrice ?? ""}",)
                                    ),
                                  ],
                                ),

                              ],
                            ),

                            /// description

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                productProvider.selectedProduct?.productDescription ?? "",
                                maxLines: 100,
                                textAlign: TextAlign.justify,
                              ),
                            ),


                            /// flags

                            Center(
                              child: Row(
                                children: [
                                  InkWell(onTap: (){},
                                      child: const Icon(Icons.flag, color: Colors.red,)),
                                  InkWell(onTap: (){},
                                      child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    ):const Text("No Product selected!");
  });
}


