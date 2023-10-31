import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/policies/privacy-policy.dart';
import 'package:digiday_admin_panel/features/policies/refund-and-cancellation-policy.dart';
import 'package:digiday_admin_panel/features/policies/terms-and-conditions.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
           ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: ()=>Get.toNamed(AppRoutes.editProfileScreen)
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Terms & Conditions",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Get.to(()=> TermsAndConditions());
            },
          ),
          ProfileMenu(
              text: "Privacy policy",
              icon: "assets/icons/User Icon.svg",
              press: ()=>Get.to(()=> PrivacyPolicy())
          ),
          ProfileMenu(
            text: "Refund & cancellation",
            icon: "assets/icons/Cash.svg",
            press: () => {
              Get.to(()=>RefundPolicy())
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: ()=> CommonFunctions.logoutUser(),
          ),
        ],
      ),
    );
  }
}
