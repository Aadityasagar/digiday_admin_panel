import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:flutter/material.dart';
enum ConnectivityStatus { WiFi, Cellular, Offline }
class NetworkProvider extends ChangeNotifier{
  late Connectivity _connectivity;
  ConnectivityStatus _status = ConnectivityStatus.Offline;

  NetworkProvider() {
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _status = ConnectivityStatus.WiFi;
        break;
      case ConnectivityResult.mobile:
        _status = ConnectivityStatus.Cellular;
        break;
      case ConnectivityResult.none:
        _status = ConnectivityStatus.Offline;
        break;
      case ConnectivityResult.bluetooth:
        // TODO: Handle this case.
      case ConnectivityResult.ethernet:
        // TODO: Handle this case.
      case ConnectivityResult.vpn:
        // TODO: Handle this case.
      case ConnectivityResult.other:
        // TODO: Handle this case.
    }
    notifyListeners();

    if (_status == ConnectivityStatus.Offline) {
      showDisconnectedSnackbar(); // Show snackbar when offline
    }
  }


  void showDisconnectedSnackbar() {
    CommonFunctions.showSnackBar(title: "Offline", message: "Check your internet connection", type: PopupType.error);
  }


  ConnectivityStatus get status => _status;

  bool get isConnectedToInternet => (_status!=ConnectivityStatus.Offline) ? true:false;
}