import 'package:digiday_admin_panel/components/coustom_bottom_nav_bar.dart';
import 'package:digiday_admin_panel/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  HomeController _homeController=Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
