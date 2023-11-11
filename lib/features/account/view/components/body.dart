import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
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
            icon: CupertinoIcons.person_alt,
            press: ()=>Get.toNamed(AppRoutes.editProfileScreen)
          ),
          ProfileMenu(
            text: "Notifications",
            icon: CupertinoIcons.bell_fill,
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {},
          ),



          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: ()=> CommonFunctions.logoutUser(),
          ),
        ],
      ),
    );
  }
}
