import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_menu.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_pic.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreDrawer extends StatelessWidget {

  const ExploreDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          const SizedBox(height: 20),
          ProfileMenu(
            text: "All Vendors",
            icon: Icons.add_business_sharp,
            press: () {
              Navigator.of(context).pushReplacementNamed(Routes.vendorScreen);
            },
          ),
          ProfileMenu(
            text: "All Circle Managers",
            icon: Icons.person,
            press: () {
              Navigator.of(context).pushReplacementNamed(Routes.cmScreen);
            },
          ),
          ProfileMenu(
            text: "All Products",
            icon: Icons.account_balance_wallet_rounded,
            press: () {
              Navigator.of(context).pushReplacementNamed(Routes.productsScreen);
            },
          ),
          ProfileMenu(
            text: "All Categories",
            icon: Icons.category,
            press: () {
              Navigator.of(context).pushReplacementNamed(Routes.categoriesScreen);
            },
          ),
          ProfileMenu(
            text: "Subscriptions",
            icon: Icons.monetization_on_sharp,
            press: () {
              Navigator.of(context).pushReplacementNamed(Routes.subscribersScreen);
            },
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
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Copyright © 2023 | DIGIDAY',
              style: TextStyle(
                color: ColourScheme.secondaryColor,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
