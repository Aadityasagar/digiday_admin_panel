// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:hikesmoney/constants.dart';
// import 'package:hikesmoney/features/business/controllers/business_controller.dart';
// import 'package:hikesmoney/size_config.dart';
//
// import 'toggle_button.dart';
//
// class ShopHeader extends StatefulWidget {
//    const ShopHeader({Key? key}) : super(key: key);
//
//   @override
//   State<ShopHeader> createState() => _ShopHeaderState();
// }
//
// class _ShopHeaderState extends State<ShopHeader> {
//   final BusinessController _businessController=Get.find<BusinessController>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height:MediaQuery.of(context).size.height/4,
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 180,
//                   decoration:const BoxDecoration(
//                     image:  DecorationImage(
//                       image:  AssetImage('assets/images/cover.jpg',),
//                       fit: BoxFit.cover
//                     )
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: (MediaQuery.of(context).size.width/3),
//             bottom: 1,
//             child:SizedBox(
//               height: 125,
//               width: 125,
//               child:Stack(
//                 fit: StackFit.expand,
//                 clipBehavior: Clip.none,
//                 children: [
//                   (_businessController.getBusinessData?.profilePicture == null || _businessController.getBusinessData?.profilePicture == "") ? const CircleAvatar(
//                     backgroundImage:  AssetImage("assets/images/placeholder-store.jpeg"),
//                   ):
//                   _businessController.businessProfilePic?.value!=""? CircleAvatar(
//                     backgroundImage:  NetworkImage(_businessController.businessProfilePic!.value!),
//                   ):SizedBox(),
//                   Positioned(
//                     right: -16,
//                     bottom: 0,
//                     child: SizedBox(
//                       height: 46,
//                       width: 46,
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                             side: BorderSide(color: Colors.white),
//                           ),
//                           primary: Colors.white,
//                           backgroundColor: Color(0xFFF5F6F9),
//                         ),
//                         onPressed: () => {
//                         //  _accountController.selectProfilePic()
//                         },
//                         child: SvgPicture.asset("assets/icons/CameraIcon.svg"),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//
//               IconButton(
//                 icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
//                 onPressed: (){
//                   Get.back();
//                 },)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
