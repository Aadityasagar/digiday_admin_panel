import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  Connectivity connectivity = Connectivity();
  var isConnected = false.obs;
  bool get isConnectedToInternet => isConnected.value;

  @override
  onInit() {
    super.onInit();
    // addConnectionListener();
  }

  @override
  dispose() {
    super.dispose();
  }

  // add listener to connectivity stream
  // addConnectionListener() async{
  //   connectivity.onConnectivityChanged.listen((event) {
  //     onConnectionChange(event);
  //   });
  //   var _result =  await connectivity.checkConnectivity();
  //   onConnectionChange(_result);
  // }

  // on connection change
  // onConnectionChange(ConnectivityResult event) {
  //   print("connection changed to --> $event");
  //   switch (event) {
  //     case ConnectivityResult.wifi:
  //       isConnected.value = true;
  //
  //       break;
  //     case ConnectivityResult.ethernet:
  //       isConnected.value = true;
  //
  //       break;
  //     case ConnectivityResult.mobile:
  //       isConnected.value = true;
  //       break;
  //     case ConnectivityResult.none:
  //       isConnected.value = false;
  //       CommonFunctions.showSnackBar(title: "No Internet!", message: "Check your internet connection!", type: PopupType.error);
  //       break;
  //     case ConnectivityResult.bluetooth:
  //       // TODO: Handle this case.
  //     case ConnectivityResult.vpn:
  //       // TODO: Handle this case.
  //   }
  // }


}