import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_menu.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_pic.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreDrawer extends StatelessWidget {

  ExploreDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Center(child: ProfilePic()),
              const SizedBox(height: 20),
              ProfileMenu(
                  text: "My Account",
                  icon: CupertinoIcons.person_alt,
                  press: (){}
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
                press: ()=> CommonFunctions.logoutUser(context),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2023 | DIGIDAY',
                    style: TextStyle(
                      color: ColourScheme.secondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
