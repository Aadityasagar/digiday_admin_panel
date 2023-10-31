import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/theme.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:digiday_admin_panel/utils/services/network/api_base_helper.dart';
import 'package:digiday_admin_panel/utils/services/network/connection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyAEUp2fIjgcEDgaFXNsKHh3yqEGA1VAmm0",
      appId: "1:606357839477:web:6b1ecc6b6d6e4633e1a23c",
      messagingSenderId: "606357839477",
      projectId: "digiday-7570a"));
  setDefault();
  runApp(MyApp());
}

void setDefault() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  Get.put(ConnectionController(),permanent: true);
  Get.put(AppSessionController(), permanent: true);
  Get.put(ApiBaseHelper(), permanent: true);

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
