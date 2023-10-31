import 'package:digiday_admin_panel/features/splash/controller/splash_controller.dart';
import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreenController _splashScreenController=Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/logo-rec.png",width: 250,),
              const Text(
               "Welcome to DigiDay Admin App",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }




}
