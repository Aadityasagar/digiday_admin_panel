import 'package:digiday_admin_panel/screens/account/view/profile_screen.dart';
import 'package:digiday_admin_panel/screens/login/sign_in_screen.dart';
import 'package:digiday_admin_panel/screens/cm/cm_screen.dart';
import 'package:digiday_admin_panel/screens/home/home_page.dart';
import 'package:digiday_admin_panel/screens/vendor/vendor_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String account = '/account';
  static const String home = '/home';
  static const String cmScreen = '/cmScreen';
  static const String vendorScreen = '/vendorScreen';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LogInScreen(),
    account: (BuildContext context) => ProfileScreen(),
    home: (BuildContext context) => HomePage(),
    cmScreen: (BuildContext context) => CmScreen(),
    vendorScreen: (BuildContext context) => VendorScreen(),
  };
}