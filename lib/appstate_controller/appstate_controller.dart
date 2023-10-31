import 'package:get/get.dart';

class AppStateController extends GetxController{
  RxString currentHover="".obs;




  void onHover(String page){
    currentHover.value=page;
  }

  void exitHover(){
    currentHover.value="";
  }

}