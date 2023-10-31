// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hikesmoney/constants.dart';
// import 'package:hikesmoney/features/business/controllers/business_controller.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../size_config.dart';
//
// class ProfileButtons extends StatelessWidget {
//
//   final BusinessController _businessController=Get.find<BusinessController>();
//
//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<ProfileButton> buttons = [
//       ProfileButton(title: "Call", icon: Icons.phone, press: (){
//         _launchUrl("tel:+91${_businessController.getBusinessData?.phoneNumber}");
//       }),
//       ProfileButton(title: "Location", icon: Icons.location_on_sharp, press: (){}),
//       ProfileButton(title: "Message", icon: Icons.chat_bubble, press: (){
//         _launchUrl("https://wa.me/${_businessController.getBusinessData?.phoneNumber}&text=Hi");
//       }),
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(
//           buttons.length,
//               (index) => ProfileButtonsCard(
//             icon: buttons[index].icon,
//             title: buttons[index].title,
//             press: buttons[index].press,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class ProfileButton{
//   String title;
//   IconData icon;
//   VoidCallback press;
//
//   ProfileButton({
//     required this.title,
//     required this.icon,
//     required this.press
//   });
// }
//
// class ProfileButtonsCard extends StatelessWidget {
//   const ProfileButtonsCard({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.press,
//   }) : super(key: key);
//
//   final String title;
//   final IconData icon;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: Column(
//         children: [
//           Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Icon(icon, color: Colors.white, size: 35,),
//           ),
//           const SizedBox(height: 5),
//           Text(title!, textAlign: TextAlign.center,
//             style: const TextStyle(
//                 color: Colors.black
//             ),)
//         ],
//       ),
//     );
//   }
// }
