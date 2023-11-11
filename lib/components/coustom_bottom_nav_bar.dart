import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {

  AppSessionController _appSessionController=Get.find<AppSessionController>();

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor =  Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home,),
                color: MenuState.home == _appSessionController.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
                onPressed: () {
                  _appSessionController.selectedMenu=MenuState.home;
                  Get.toNamed(AppRoutes.homeScreen);
                },
              ),

              IconButton(
                  icon: const Icon(Icons.wallet),
                  color: MenuState.shop == _appSessionController.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  onPressed: () {
                    _appSessionController.selectedMenu=MenuState.shop;
                    // Get.toNamed(AppRoutes.myShopScreen);
                   // Get.to(()=>WalletScreen());
                  }),

              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: const Icon(Icons.person),
                color: MenuState.profile == _appSessionController.selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
                onPressed: () {
                  _appSessionController.selectedMenu=MenuState.profile;
                  Get.toNamed(AppRoutes.profileScreen);
                },
              ),
            ],
          )),
    );
  }
}
