


import 'package:digiday_admin_panel/utils/app_utility.dart';

class AppVersion {
  static const String _currentVersion = "v4.3.0";
  static const String _buildNumberAndroid = "4146";
  static const String _buildNumberIOS = "1";
  static final DateTime _date = DateTime(2023, 06, 06); // YYYY, Month, Day

  // get Release Date
  static getDate() {
    return AppUtility().getDayYearMoth(_date);
  }

  // get Release version
  static String get currentVersion {
    return _currentVersion;
  }
}
