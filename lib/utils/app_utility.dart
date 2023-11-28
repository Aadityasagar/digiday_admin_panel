import 'dart:convert';
import 'dart:io';
import 'package:digiday_admin_panel/constants/date_constants.dart';
import 'package:digiday_admin_panel/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path_package;

class AppUtility {


  static bool get isTestModeActive =>
      Platform.environment.containsKey('FLUTTER_TEST');

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  Future<void> handleURL(String url) async {
    Uri? uri = Uri.tryParse(url);
    if(uri!=null){
      if (!await launchUrl(uri)) throw 'Could not launch $url';
    }
  }

  static Future<String> getBase64FromFile(File file) async {
    var bytes = file.readAsBytesSync();
    String _base64String = base64.encode(bytes);
    return _base64String;
  }

  static String getExtension(String path) {
    String path0 = path;
    String extension = path_package.extension(path0);
    return extension.split(".").last.toUpperCase();
  }

  static String getFirstCharacter(String? text) {
    String value = "";
    if (text?.isNotEmpty ?? false) {
      value = text![0];
    }
    return value;
  }

  String dateFormarDDMMYYYY(DateTime date) {
    var dateFormat = DateFormat(DateConstants.kDateFormat);
    return dateFormat.format(date);
  }

  String getDayYearMoth(DateTime date) {
    var dateFormat = DateFormat(DateConstants.kDayDayDateFormat);
    return dateFormat.format(date);
  }

  //In the form of 'December 16, 2021'
  static String getFormattedDate(DateTime dateTime) {
    var dateFormat = DateFormat(DateConstants.kDateFormat3);

    return dateFormat.format(dateTime);
  }

  //In the form of '16 Dec 2021'
  static String getDDMMMYYYY(DateTime dateTime) {
    var dateFormat = DateFormat(DateConstants.kDateFormat4);

    return dateFormat.format(dateTime);
  }

  // DateTime getUserTimeZoneDate(DateTime dateTime) {
  //   return addSubsDate1(
  //       _appState.getProfileInfo!.timeZone!.substring(3), dateTime);
  // }



  String getFormatedDateFromEpoc(int epoc,String zone) {
    DateTime epocTime = convertEPOCToURC(epoc);
    DateTime tempTime =
    addSubsDate(zone.substring(3), epocTime);
    DateFormat format = DateFormat(DateConstants.kDateFormat5);

    return format.format(tempTime);
  }

  String getDateFromEpoc(int epoc,String zone) {
    DateTime epocTime = convertEPOCToURC(epoc);
    DateTime tempTime =
    addSubsDate(zone.substring(3), epocTime);
    DateFormat format = DateFormat(DateConstants.kDateFormat1);

    return format.format(tempTime);
  }

  DateTime getDateTimeFromString(String format, String date) {
    DateTime result = DateFormat(format).parse(date);
    return result;
  }

  /*For notification List*/
  String getDateFromEpocWithTime(int epoc,String zone) {
    DateTime epocTime = convertEPOCToURC(epoc);
    DateTime timeStamp =
    addSubsDate(zone.substring(3), epocTime);
    String date;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(timeStamp.year, timeStamp.month, timeStamp.day);
    if (aDate == today) {
      final DateFormat dateFormat = DateFormat(DateConstants.kDateFormatHHMM);
      date = dateFormat.format(timeStamp);
    } else if (aDate == yesterday) {
      date = "yesterday"; //todo change
    } else {
      DateFormat dateFormat;
      if (timeStamp.year.isEqual(now.year)) {
        dateFormat = DateFormat(DateConstants.kDateFormatWithoutYear);
      } else {
        dateFormat = DateFormat(DateConstants.kDateFormat);
      }
      date = dateFormat.format(timeStamp);
    }

    return date;
  }



  DateTime convertEPOCToURC(int epocTime) {
    DateTime date =
    DateTime.fromMicrosecondsSinceEpoch(epocTime * 1000).toUtc();
    return date;
  }

  String getTimeAgoFromEPOC(int epocTime) {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(epocTime * 1000).toUtc();
    return DateTimeExtension.getTimeAgo(secondDate: date);
  }



  DateTime addSubsDate(String timeZone, DateTime timeStamp) {
    if (timeZone.startsWith("-")) {
      return timeStamp.subtract(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(4, 6))));
    } else {
      return timeStamp.add(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(4, 6))));
    }
  }

/*  DateTime addSubsDate1(String timeZone, DateTime timeStamp) {
    if (timeZone.startsWith("+")) {
      return timeStamp.subtract(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(4, 6))));
    } else {
      return timeStamp.subtract(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(4, 6))));
    }
  }*/

  DateTime addSubsDateWithTenantTimeZone(String timeZone, DateTime timeStamp) {
    if (timeZone.startsWith("-")) {
      return timeStamp.add(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(3, 5))));
    } else {
      return timeStamp.subtract(Duration(
          hours: int.parse(timeZone.substring(1, 3)),
          minutes: int.parse(timeZone.substring(3, 5))));
    }
  }



  ///   Convert Any Size Unit to Bytes
  ///  eg Method convert "100MB" to bytes
  static int getSizeInBytes(String value) {
    var digits = value.replaceAll(RegExp('[^0-9]'), '');
    var unit = value.replaceAll(RegExp('[^A-Za-z]'), '');
    int size = int.tryParse(digits) ?? 0;
    int sizeInBytes = 0;
    int factor = 1024;
    int bytesInKB = factor;
    int bytesInMB = bytesInKB * factor;
    int bytesInGB = bytesInMB * factor;
    int bytesInTB = bytesInGB * factor;
    switch (unit.toLowerCase()) {
      case "bytes":
        sizeInBytes = size;
        break;
      case "kb":
        sizeInBytes = size * bytesInKB;
        break;
      case "mb":
        sizeInBytes = size * bytesInMB;
        break;
      case "gb":
        sizeInBytes = size * bytesInGB;
        break;
      case "tb":
        sizeInBytes = size * bytesInTB;
        break;
    }
    return sizeInBytes;
  }

  /// Convert Bytes  to MB
  static double convertBytesToMB(int bytes) {
    int factor = 1024;
    return (bytes / factor) / factor;
  }

  /// Method to show File Size in KB and MB
  static String getCustomSizeUnit(int bytes) {
    //INCOMPLETE -- To be Used later
    String unit = "bytes";
    double value = 0.0;
    int factor = 1024;
    int bytesInKB = factor;
    int bytesInMB = bytesInKB * factor;
    int bytesInGB = bytesInMB * factor;
    int bytesInTB = bytesInGB * factor;

    if (bytes < bytesInMB) {
      value = bytes / bytesInKB;
      unit = "KB";
    } else if (bytes < bytesInGB) {
      value = bytes / bytesInMB;
      unit = "MB";
    } else if (bytes < bytesInTB) {
      value = bytes / bytesInGB;
      unit = "GB"; // Not a use case for our app
    } else {
      value = bytes / bytesInTB;
      unit = "TB";
    }

    return value.toStringAsFixed(2) + unit;
  }


  //Convert  "1.2M" instead of "1,200,000".
  static String getCompactNumber(int value){
    NumberFormat format=  NumberFormat.compact();
    return  format.format(value);
  }
}