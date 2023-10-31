import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/asset_files.dart';
import 'package:digiday_admin_panel/constants/validator_constants.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/svg_image.dart';
import 'package:digiday_admin_panel/features/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/utils/app_utility.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_pref_keys.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_prefrence_refs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/alerts-and-popups/single_button_popup.dart';

class CommonFunctions {
  ///Function used to [Logout] the user from the app
  static Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    await Get.offAllNamed(AppRoutes.emailLogin);
  }

  static Future<void> clearSessionData() async{
    await Future.wait([
      SharedPreferenceRef.instance.removeValue(key: SharedPrefsKeys.kTokenData),
      SharedPreferenceRef.instance.removeValue(key: SharedPrefsKeys.kProfileData)
    ]);
  }


  ///Function to check the valid [email]
  static bool isValidEmail(String email) {
    const String pattern = kEmailRegex;
    final RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmail(String email) {
    const String pattern = kEmailRegex;
    final RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return false;
    } else {
      return true;
    }
  }

  ///function to show the error [dialog]

  ///function to show the custom [Snackbar]
  static showCustomSnackbar({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 2),
    OnTap? onTap,
    SnackStyle snackStyle = SnackStyle.FLOATING,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 10),
    EdgeInsets padding = const EdgeInsets.all(16),
    bool isDismissible = true,
  }) {
    return Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      duration: duration,
      onTap: onTap,
      snackStyle: snackStyle,
      isDismissible: isDismissible,
      margin: margin,
      padding: padding,
    );
  }

  ///function to show the error [dialog]
  static showDialogBox(
      {String? message,
        String? header,
        List<ActionButton>? actions,
        String? routeName,
        PopupType? popupType}) async {
    if (AppUtility.isTestModeActive || routeName != null && routeName != Get.currentRoute) {
      return;
    }
    return await Get.dialog(AppThemedPopup(
      title: header,
      message: message,
      actions: actions!,
      type: popupType,
    ));
  }

  // TODO Why
  static Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: AppThemedLoader(
              isTransparent: true,
            ),
          ),
        ),
      ),
    );
  }

  static showAppThemedAlert(
      {String? message,
        String? header,
        List<ActionButton>? actions,
        PopupType? popupType}) async {
    return await Get.dialog(AppThemedDialog(
      title: header,
      message: message,
      actions: actions!,
      type: popupType,
    ));
  }


  //function to show popup with svg
  static showAppThemedAlertWithSvg(String svg,
      {String? message,
        String? header,
        List<ActionButton>? actions,
        PopupType? popupType}) async {
    return await Get.dialog(AppThemedDialogWithSvg(
      title: header,
      svg: svg,
      message: message,
      actions: actions!,
      type: popupType,
    ));
  }


  static closeOverlayDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }


  static showSnackBar(
      {required title, required message, required PopupType type}) {
    if(AppUtility.isTestModeActive){
      return;
    }
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: getSnackBarColor(type),
        margin:const EdgeInsets.fromLTRB(10, 0, 10, 10),
        colorText: Colors.white,
        padding: const EdgeInsets.only(left: 50,right: 8),
        icon: Stack(
          alignment: Alignment.center,
          children: [
            const SvgImage(AssetStrings.snackBG),
            Icon(
              getIconData(type),
              color: Colors.white,
              size: 35,
            )
          ],
        ));
  }

  static getSnackBarColor(PopupType type) {
    switch (type) {
      case PopupType.success:
        return kPrimaryColor;

      case PopupType.warning:
        return Colors.orange;

      case PopupType.error:
        return Colors.red;

      case PopupType.info:
        return Colors.blue;

    }
  }

  static IconData? getIconData(PopupType type) {
    switch (type) {
      case PopupType.success:
        return Icons.check;

      case PopupType.error:
        return Icons.close;

      case PopupType.warning:
        return Icons.warning_amber_outlined;

      case PopupType.info:
        return Icons.info_outlined;

    }
  }

  /// common text widget with having underline
  static Container underlinedText({required BuildContext context, required Widget title}){
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
      ),
      child: title,
    );
  }
}