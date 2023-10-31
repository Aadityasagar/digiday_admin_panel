import 'package:digiday_admin_panel/components/coustom_bottom_nav_bar.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/account_controller.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  final AccountController _accountController=Get.find<AccountController>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
          ),
          body: Body(),
          bottomNavigationBar: CustomBottomNavBar(),
        ),
        Obx(() =>  Offstage(
            offstage: !_accountController.isLoading.value,
            child: AppThemedLoader()))
      ],
    );
  }
}
