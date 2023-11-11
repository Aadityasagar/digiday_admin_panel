import 'package:digiday_admin_panel/features/account/view/edit_profile_screen.dart';
import 'package:digiday_admin_panel/features/account/view/profile_screen.dart';
import 'package:digiday_admin_panel/features/auth/views/log_in/sign_in_screen.dart';
import 'package:digiday_admin_panel/features/auth/views/register_admin/business_details_screen.dart';
import 'package:digiday_admin_panel/features/auth/views/register_admin/register_screen.dart';
import 'package:digiday_admin_panel/features/products/add_products.dart';
import 'package:digiday_admin_panel/features/products/products_screen.dart';
import 'package:digiday_admin_panel/features/splash/view/splash_screen.dart';
import 'package:digiday_admin_panel/screens/cm/cm_screen.dart';
import 'package:digiday_admin_panel/screens/vendors/vendor_screen.dart';
import 'package:get/get.dart';

import '../../screens/home/home_page.dart';


part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreenWithEmail(),
    ),
    GetPage(
      name: AppRoutes.businessDetails,
      page: () => BusinessDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.emailLogin,
      page: () => LogInScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () =>HomePage(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.editMyBusinessScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.addProduct,
      page: () => const AddProduct(),
    ),

    GetPage(
      name: AppRoutes.products,
      page: () =>  ProductScreen(),
    ),
    GetPage(
      name: AppRoutes.vendors,
      page: () =>  VendorScreen(),
    ),
    GetPage(
      name: AppRoutes.cms,
      page: () =>  CmScreen(),
    )
  ];
}