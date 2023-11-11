// import 'package:digiday_admin_panel/components/coustom_bottom_nav_bar.dart';
// import 'package:digiday_admin_panel/constants.dart';
// import 'package:digiday_admin_panel/features/business/controllers/business_controller.dart';
// import 'package:digiday_admin_panel/features/business/edit_business.dart';
// import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
// import 'package:digiday_admin_panel/features/offers/add_offer.dart';
// import 'package:digiday_admin_panel/features/offers/components/offer_card_widget.dart';
// import 'package:digiday_admin_panel/features/offers/controller/offer_controller.dart';
// import 'package:digiday_admin_panel/features/offers/offers_screen.dart';
// import 'package:digiday_admin_panel/features/products/add_products.dart';
// import 'package:digiday_admin_panel/size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../home/components/section_title.dart';
//
// class MyShopScreen extends StatelessWidget {
//   final BusinessController _businessController=Get.find<BusinessController>();
//   final OfferController _offersController=Get.find<OfferController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<BusinessController>(
//         builder: (business) =>  Stack(
//           children: [
//             Scaffold(
//               body: SafeArea(
//                 child: SingleChildScrollView(
//                   physics: const ScrollPhysics(),
//                   child: Column(
//                     children: [
//                       // Container(
//                       //   height: MediaQuery.of(context).size.height/4,
//                       //   width: double.infinity,
//                       //   child: const ShopHeader(),),
//                       Container(
//                         height: MediaQuery.of(context).size.height/8,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:  [
//                               Flexible(
//                                 child: Text(_businessController?.getBusinessData?.businessName??"",
//                                   style: const TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       overflow: TextOverflow.ellipsis
//                                   ),
//                                   maxLines: 1,),
//                               ),
//
//                               SizedBox(height: getProportionateScreenWidth(5)),
//
//                               Row(
//                                 children: [
//                                   const Icon(Icons.location_on_sharp,
//                                     color: kPrimaryColor,),
//                                   SizedBox(width: getProportionateScreenWidth(5)),
//                                   Flexible(
//                                     child: Text("${_businessController?.getBusinessData?.address},${_businessController?.getBusinessData?.city},${_businessController?.getBusinessData?.state},${_businessController?.getBusinessData?.pinCode}"??"",
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       maxLines: 2,),
//                                   ),
//                                   SizedBox(width: getProportionateScreenWidth(5)),
//                                   IconButton(onPressed: (){
//                                     Get.to(()=> EditBusiness());
//                                   }, icon: const Icon(Icons.edit,
//                                     color: kPrimaryColor,)) ,
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: getProportionateScreenWidth(10)),
//                       // ProfileButtons(),
//                       Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//                         child: SectionTitle(
//                           title: "My Offers",
//                           press: () {
//                             Get.to(const OffersScreen());
//                           },
//                         ),
//                       ),
//                       SizedBox(height: getProportionateScreenWidth(20)),
//                   _offersController.offers.length!=0  ?
//
//                   SingleChildScrollView(
//                     child: SizedBox(
//                       height: 220,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _offersController.offers.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return OfferCard(
//                               offerData: _offersController.offers[index],
//                             );
//                           }
//                       ),
//                     ),
//                   ) : Center(child: InkWell(onTap: ()=> Get.to(()=>const AddOffer()),
//                       child: Container(
//                     width: MediaQuery.of(context).size.width/2,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                       border: Border.all(color: kPrimaryColor)
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(Icons.add),
//                           SizedBox(width: 5,),
//                           Text("Add New Offer",
//                           style: TextStyle(
//                             fontSize: 19,
//
//                           ),),
//                         ],
//                       ),
//                     ),
//                   ))),
//
//                       Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//                         child: SectionTitle(
//                           title: "My Products",
//                           press: () {
//                             Get.to(const OffersScreen());
//                           },
//                         ),
//                       ),
//
//                       SizedBox(height: getProportionateScreenWidth(30)),
//                       _offersController.products.length!=0  ?
//
//                       SingleChildScrollView(
//                         child: SizedBox(
//                           height: 220,
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               itemCount: _offersController.products.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return ProductCard(product: _offersController.products[index]);
//                               }
//                           ),
//                         ),
//                       ) : Center(child: InkWell(onTap: ()=> Get.to(()=>const AddProduct()),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width/2,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(color: kPrimaryColor)
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Icon(Icons.add),
//                                   SizedBox(width: 5,),
//                                   Text("Add Product",
//                                     style: TextStyle(
//                                       fontSize: 19,
//
//                                     ),),
//                                 ],
//                               ),
//                             ),
//                           ))),
//                       SizedBox(height: getProportionateScreenWidth(30)),
//                     ],
//                   ),
//                 ),
//               ),
//               bottomNavigationBar: CustomBottomNavBar(),
//             ),
//             Obx(() =>  Offstage(
//                 offstage: !_businessController.isLoading.value,
//                 child: const AppThemedLoader()))
//           ],
//         ));
//   }
// }
