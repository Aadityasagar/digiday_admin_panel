import 'package:digiday_admin_panel/provider/categories_provider.dart';
import 'package:digiday_admin_panel/provider/products_provider.dart';
import 'package:digiday_admin_panel/provider/vendors_provider.dart';
import 'package:digiday_admin_panel/screens/login/sign_in_screen.dart';
import 'package:digiday_admin_panel/provider/app_session_provider.dart';
import 'package:digiday_admin_panel/provider/account_provider.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
import 'package:digiday_admin_panel/provider/network_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/home/home_page.dart';
import 'package:digiday_admin_panel/utils/services/network/api_base_helper.dart';
import 'package:digiday_admin_panel/utils/services/network/connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyAEUp2fIjgcEDgaFXNsKHh3yqEGA1VAmm0",
      appId: "1:606357839477:web:6b1ecc6b6d6e4633e1a23c",
      messagingSenderId: "606357839477",
      projectId: "digiday-7570a",
      storageBucket: "digiday-7570a.appspot.com",
  ));

  //setDefault();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => AppSessionProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => CmProvider()),
        ChangeNotifierProvider(create: (_) => VendorProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
      ],
      child: MyApp(
      )));
}

void setDefault() {
  Get.put(ConnectionController(),permanent: true);
  Get.put(ApiBaseHelper(), permanent: true);
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyApp",
      routes: Routes.routes,
      home: Consumer<AccountProvider>(
        builder: (_, authProviderRef, __) {
            debugPrint("${authProviderRef.currentUserId}");
            return authProviderRef.currentUserId!=null
                ? HomePage()
                : LogInScreen();
        },
      ),
    );
  }
}
