// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hikesmoney/constants/app_urls.dart';
// import 'package:hikesmoney/features/business/controllers/business_controller.dart';
// import 'package:hikesmoney/features/offers/components/offer_detail_card_widget.dart';
// import 'package:hikesmoney/features/offers/data/offer_model.dart';
// import 'package:hikesmoney/size_config.dart';
// import 'package:hikesmoney/utils/services/network/firebase_service.dart';
//
// class OfferCard extends StatelessWidget {
//   const OfferCard({
//     Key? key,
//     required this.offerData
//   }) : super(key: key);
//
//   final Offer offerData;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     BusinessController _businessController=Get.find<BusinessController>();
//     return Container(
//       width:( MediaQuery.of(context).size.width/1)-50,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10.0),
//         child: GestureDetector(
//           onTap: (){
//             showModalBottomSheet<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return Container(color: const Color(0xFF737373),
//                   height: MediaQuery.of(context).size.height/1.2,
//                   child: Container(decoration: BoxDecoration(color: Colors.blue.shade50,
//                       borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(25), topLeft:Radius.circular(25) )),
//                     child:  OfferDetailsCard(
//                       offerData: offerData
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           child: Material(
//             elevation: 3,
//             borderRadius: BorderRadius.circular(25),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal:10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: getProportionateScreenWidth(295),
//                           height: getProportionateScreenHeight(127),
//                           child: FutureBuilder(
//                             future: FirebaseService.getImageUrl("${ApiUrl.offerBannersFolder}/${offerData.offerBanner!}"),
//                             builder: (context, snapshot) {
//                               if (snapshot.hasError) {
//                                 return const Text(
//                                   "Something went wrong",
//                                 );
//                               }
//                               if (snapshot.connectionState == ConnectionState.done) {
//                                 return ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.network(
//                                     snapshot.data.toString(),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 );
//                               }
//                               return const Center(child: CircularProgressIndicator());
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:10.0),
//                       child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         Text(offerData.offerTitle!,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w800,
//                             fontSize: 16
//                           ),
//                         textAlign: TextAlign.start,
//                           overflow: TextOverflow.clip,
//                           softWrap: true,
//                           maxLines: 1,
//                         ),
//                        const SizedBox(
//                           height: 2,
//                         ),
//                        Row(
//                          children: [
//                            const Icon(Icons.location_on_sharp,size: 20,
//                            color: Colors.grey,),
//                            const SizedBox(height: 5,),
//                            Expanded(
//                              child: Text("${_businessController.getBusinessData?.address},${_businessController.getBusinessData?.city},${_businessController.getBusinessData?.state}",
//                                style: const TextStyle(
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: 14
//                                ),
//                                textAlign: TextAlign.start,
//                              overflow: TextOverflow.clip,
//                              softWrap: true,
//                              maxLines: 2,),
//                            )
//                          ],
//                        )
//
//                       ],
//                   ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }