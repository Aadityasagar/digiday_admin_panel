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
                drawer: ExploreDrawer(),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child:

              AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: productProvider.selectedProduct!.id.toString(),
                  child:  FutureBuilder(
                    future: FirebaseService.getImageUrl("${ApiUrl.productPicFolder}/${productProvider.selectedProduct?.productImage!}"),
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

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productCategory ?? "",
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                /// description

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    productProvider.selectedProduct?.productDescription ?? "",
                    maxLines: 10,
                    textAlign: TextAlign.justify,
                  ),
                ),

                /// see more details

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Text(
                          "See More Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),

                /// flags

                Row(
                  children: [
                    InkWell(onTap: (){},
                        child: const Icon(Icons.flag, color: Colors.red,)),
                    InkWell(onTap: (){},
                        child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  });
}

Widget getTabProductsDetailsScreen(BuildContext context) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child:AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: productProvider.selectedProduct!.id.toString(),
                  child:  FutureBuilder(
                    future: FirebaseService.getImageUrl("${ApiUrl.productPicFolder}/${productProvider.selectedProduct?.productImage!}"),
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

                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    productProvider.selectedProduct?.productCategory ?? "",
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                /// description

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    productProvider.selectedProduct?.productDescription ?? "",
                    maxLines: 10,
                    textAlign: TextAlign.justify,
                  ),
                ),

                /// see more details

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Text(
                          "See More Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),

                /// flags

                Row(
                  children: [
                    InkWell(onTap: (){},
                        child: const Icon(Icons.flag, color: Colors.red,)),
                    InkWell(onTap: (){},
                        child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  });
}

Widget getDesktopProductsDetailsScreen() {
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
                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child:AspectRatio(
                            aspectRatio: 1,
                            child: Hero(
                              tag: productProvider.selectedProduct!.id.toString(),
                              child:  FutureBuilder(
                                future: FirebaseService.getImageUrl("${ApiUrl.productPicFolder}/${productProvider.selectedProduct?.productImage!}"),
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

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                productProvider.selectedProduct?.productCategory ?? "",
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            /// description

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                productProvider.selectedProduct?.productDescription ?? "",
                                maxLines: 10,
                                textAlign: TextAlign.justify,
                              ),
                            ),

                            /// see more details

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Text(
                                      "See More Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// flags

                            Row(
                              children: [
                                InkWell(onTap: (){},
                                    child: const Icon(Icons.flag, color: Colors.red,)),
                                InkWell(onTap: (){},
                                    child: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,))
                              ],
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
    );
  });
}


