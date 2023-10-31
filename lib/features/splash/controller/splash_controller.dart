import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
final AppSessionController _appSessionController=Get.find<AppSessionController>();
  @override
  void onInit() {
    // TODO: implement onInit

    Future.delayed(const Duration(seconds: 2), () async{

        bool isUserLoggedIn=await _appSessionController.isUserLoggedIn();
        Get.offAllNamed(isUserLoggedIn? AppRoutes.homeScreen:AppRoutes.emailLogin);

        }
    );

    super.onInit();
  }

}