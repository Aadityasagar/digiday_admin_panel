import 'package:digiday_admin_panel/screens/account/view/profile_screen.dart';
import 'package:digiday_admin_panel/screens/categories/add_category_screen.dart';
import 'package:digiday_admin_panel/screens/categories/categories_screen.dart';
import 'package:digiday_admin_panel/screens/cm/cm_details_screen.dart';
import 'package:digiday_admin_panel/screens/login/sign_in_screen.dart';
import 'package:digiday_admin_panel/screens/cm/cm_screen.dart';
import 'package:digiday_admin_panel/screens/home/home_page.dart';
import 'package:digiday_admin_panel/screens/product/product_details_screen.dart';
import 'package:digiday_admin_panel/screens/product/products_screen.dart';
import 'package:digiday_admin_panel/screens/subscribers/subscribers_screen.dart';
import 'package:digiday_admin_panel/screens/vendor/vendor_details_screen.dart';
import 'package:digiday_admin_panel/screens/vendor/vendor_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String home = '/home';
  static const String cmScreen = '/cmScreen';
  static const String vendorScreen = '/vendorScreen';
  static const String productsScreen = '/productsScreen';
  static const String categoriesScreen = '/categoriesScreen';
  static const String productDetailsScreen = '/productDetailScreen';
  static const String cmDetailsScreen = '/cmDetailScreen';
  static const String vendorDetailsScreen = '/vendorDetailScreen';
  static const String addCategoryScreen = '/addCategoryScreen';
  static const String profileScreen = '/profileScreen';
  static const String subscribersScreen = '/subscribersScreen';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LogInScreen(),
    home: (BuildContext context) => HomePage(),
    cmScreen: (BuildContext context) => CmScreen(),
    vendorScreen: (BuildContext context) => VendorScreen(),
    productsScreen: (BuildContext context) => ProductsScreen(),
    categoriesScreen: (BuildContext context) => CategoriesScreen(),
    // productDetailsScreen: (BuildContext context) => ProductDetailsScreen(),
    cmDetailsScreen: (BuildContext context) => CmDetailsScreen(),
    vendorDetailsScreen: (BuildContext context) => VendorDetailsScreen(),
    addCategoryScreen: (BuildContext context) => AddCategoryScreen(),
    profileScreen: (BuildContext context) => ProfileScreen(),
    subscribersScreen: (BuildContext context) => SubscribersScreen(),
  };
}