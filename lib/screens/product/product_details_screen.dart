import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/models/Product.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/screens/product/products_screen.dart';
import 'package:digiday_admin_panel/screens/product/widgets/pupUp_rejection_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductDetailsScreen extends StatelessWidget {
  Product selectedProduct;


  ProductDetailsScreen({super.key,
    required this.selectedProduct
  });

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
                  largeScreen: getDesktopProductsDetailsScreen(selectedProduct),
                  smallScreen: getMobileProductsDetailsScreen(context, selectedProduct),
                  mediumScreen: getTabProductsDetailsScreen(context, selectedProduct),
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


Widget getMobileProductsDetailsScreen(BuildContext context, Product selectedProduct) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return selectedProduct!=null? SingleChildScrollView(
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
                  child: selectedProduct?.productImage==null ?
                  Image.asset("images/ProfileImage.png", height: 300, width: 300,):
                  Image.network(selectedProduct?.productImage??"", height: 300, width: 300,),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(children: [

                      /// category

                      Text(
                        selectedProduct?.productCategory ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// title

                      Text(
                        selectedProduct?.productTitle ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/30,
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),

                      /// brand

                      Text(
                        selectedProduct?.productBrand ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/60, fontWeight: FontWeight.w400,),
                      ),

                      /// price

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// sale price

                            Row(
                              children: [
                                Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text("${"₹"}${selectedProduct?.productSalePrice ?? ""}",
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

                                Text("${"₹"}${selectedProduct?.productRegularPrice ?? ""}",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                              ],
                            ),
                          ],),
                      ),
                    ],),
                  ),

                  const SizedBox(height: 10,),
                  /// description

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
                            selectedProduct?.productDescription ?? "",
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
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            selectedProduct.status=="Not Verified" ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(onPressed: (){

                  String verified= "Verified";
                  if(selectedProduct!=null) {
                    productProvider.verifyProduct(selectedProduct.id!, verified);
                    productProvider.allProductsList.remove(selectedProduct);
                    productProvider.approvedProductsList.add(selectedProduct);
                  }

                  _showApprovedSnackBar(context);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));


                },
                    color: Colors.green,
                    child: const Text('Approve',
                      style: TextStyle(
                          color: Colors.white
                      ),)),

                const SizedBox(
                  width: 20,
                ),

                MaterialButton(onPressed: (){

                  showDialog(
                    context: context,
                    builder: (context) => RejectionPopUpForm(productId: selectedProduct.id!,),
                  );
                  productProvider.allProductsList.remove(selectedProduct);
                  productProvider.rejectedProductsList.add(selectedProduct);

                  _showRejectedSnackBar(context);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));

                },
                  color: Colors.red,
                  child: const Text('Reject',
                    style: TextStyle(
                        color: Colors.white
                    ),),),
              ],
            ) : Material(
              elevation: 3,
              child: Container(
                  color: selectedProduct.status=="Verified" ? Colors.green : Colors.red,
                  child:  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(selectedProduct.status=="Verified" ? 'Approved': 'Rejected',
                      style: const TextStyle(
                          color: Colors.white
                      ),),
                  )),
            )

          ],
        ),
      ),
    ):const Text("No Product selected!");
  });
}

Widget getTabProductsDetailsScreen(BuildContext context, Product selectedProduct) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return selectedProduct!=null? SingleChildScrollView(
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
                  child: selectedProduct?.productImage==null ?
                  Image.asset("images/ProfileImage.png", height: 300, width: 300,):
                  Image.network(selectedProduct?.productImage??"", height: 300, width: 300,),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(children: [

                      /// category

                      Text(
                        selectedProduct?.productCategory ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// title

                      Text(
                        selectedProduct?.productTitle ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/30,
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),

                      /// brand

                      Text(
                        selectedProduct?.productBrand ?? "",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/60, fontWeight: FontWeight.w400,),
                      ),

                      /// price

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// sale price

                            Row(
                              children: [
                                Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text("${"₹"}${selectedProduct?.productSalePrice ?? ""}",
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

                                Text("${"₹"}${selectedProduct?.productRegularPrice ?? ""}",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                              ],
                            ),
                          ],),
                      ),
                    ],),
                  ),

                  const SizedBox(height: 10,),
                  /// description

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
                            selectedProduct?.productDescription ?? "",
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            selectedProduct.status=="Not Verified" ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(onPressed: (){

                  String verified= "Verified";
                  if(selectedProduct!=null) {
                    productProvider.verifyProduct(selectedProduct.id!, verified);
                    productProvider.allProductsList.remove(selectedProduct);
                    productProvider.approvedProductsList.add(selectedProduct);
                  }

                  _showApprovedSnackBar(context);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));


                },
                    color: Colors.green,
                    child: const Text('Approve',
                      style: TextStyle(
                          color: Colors.white
                      ),)),

                const SizedBox(
                  width: 20,
                ),

                MaterialButton(onPressed: (){

                  showDialog(
                    context: context,
                    builder: (context) => RejectionPopUpForm(productId: selectedProduct.id!,),
                  );
                  productProvider.allProductsList.remove(selectedProduct);
                  productProvider.rejectedProductsList.add(selectedProduct);

                  _showRejectedSnackBar(context);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));

                },
                  color: Colors.red,
                  child: const Text('Reject',
                    style: TextStyle(
                        color: Colors.white
                    ),),),
              ],
            ) : Material(
              elevation: 3,
              child: Container(
                  color: selectedProduct.status=="Verified" ? Colors.green : Colors.red,
                  child:  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(selectedProduct.status=="Verified" ? 'Approved': 'Rejected',
                      style: const TextStyle(
                          color: Colors.white
                      ),),
                  )),
            )

          ],
        ),
      ),
    ):const Text("No Product selected!");
  });
}

Widget getDesktopProductsDetailsScreen(Product selectedProduct) {
  return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
    return selectedProduct!=null? SingleChildScrollView(
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

                      Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                                  child: Center(
                                    child: selectedProduct?.productImage==null ?
                                    Image.asset("images/ProfileImage.png", height: 300, width: 300,):
                                    Image.network(selectedProduct?.productImage??"", height: 300, width: 300,),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            selectedProduct.status=="Not Verified" ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(onPressed: (){

                                  String verified= "Verified";
                                  if(selectedProduct!=null) {
                                    productProvider.verifyProduct(selectedProduct.id!, verified);
                                    productProvider.allProductsList.remove(selectedProduct);
                                    productProvider.approvedProductsList.add(selectedProduct);
                                  }

                                  _showApprovedSnackBar(context);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));


                                },
                                    color: Colors.green,
                                    child: const Text('Approve',
                                      style: TextStyle(
                                          color: Colors.white
                                      ),)),

                                const SizedBox(
                                  width: 10,
                                ),

                                MaterialButton(onPressed: (){

                                  showDialog(
                                    context: context,
                                    builder: (context) => RejectionPopUpForm(productId: selectedProduct.id!,),
                                  );
                                  productProvider.allProductsList.remove(selectedProduct);
                                  productProvider.rejectedProductsList.add(selectedProduct);

                                  _showRejectedSnackBar(context);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));

                                },
                                  color: Colors.red,
                                  child: const Text('Reject',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),),
                              ],
                            ) : Material(
                              elevation: 3,
                              child: Container(
                                  color: selectedProduct.status=="Verified" ? Colors.green : Colors.red,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(selectedProduct.status=="Verified" ? 'Approved': 'Rejected',
                                      style: const TextStyle(
                                          color: Colors.white
                                      ),),
                                  )),
                            )

                          ]
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      Flexible(
                        child: Container(
                          height: 330,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                          child: Column(children: [

                            const SizedBox(
                              height: 20,
                            ),

                            /// category

                            // Text(
                            //   productProvider.selectedProduct?.productCategory ?? "",
                            //   style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                            //     fontWeight: FontWeight.w600),
                            // ),
                            //
                            // const SizedBox(
                            //   height: 20,
                            // ),

                            Padding(
                              padding: const EdgeInsets.symmetric( vertical: 20, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /// title

                                  Text(
                                    selectedProduct?.productTitle ?? "",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/60,
                                        fontWeight: FontWeight.w600, color: Colors.black),
                                  ),

                                  /// brand

                                  Text(
                                    selectedProduct?.productBrand ?? "",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width/70, fontWeight: FontWeight.w500,),
                                  ),
                                ],
                              ),
                            ),

                            /// price

                            Padding(
                              padding: const EdgeInsets.symmetric( vertical: 20, horizontal: 10),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  /// sale price

                                  Row(
                                    children: [
                                      Text("Sale Price:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600),
                                      ),

                                      const SizedBox(width: 5),

                                      Text("${"₹"}${selectedProduct?.productSalePrice ?? ""}",
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

                                      Text("${"₹"}${selectedProduct?.productRegularPrice ?? ""}",
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                            fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],),
                            ),

                            const SizedBox(height: 20,),
                            /// description

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
                                      selectedProduct?.productDescription ?? "",
                                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],),
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

void _showApprovedSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('Product Approved'),
    duration: const Duration(seconds: 5), // Optional: Control how long the SnackBar is displayed
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));

      },
    ),
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void _showRejectedSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('Product Rejected'),
    duration: const Duration(seconds: 5), // Optional: Control how long the SnackBar is displayed
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsScreen()));

      },
    ),
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}



