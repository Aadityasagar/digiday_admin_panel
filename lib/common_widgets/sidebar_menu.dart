import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}