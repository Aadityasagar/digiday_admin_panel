import 'dart:convert';

import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/features/auth/data/model/profile.dart';
import 'package:digiday_admin_panel/utils/app_utility.dart';
import 'package:digiday_admin_panel/utils/shared_prefs/shared_pref_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRef {
  SharedPreferenceRef._privateConstructor() {
    AndroidOptions androidOpt = const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    IOSOptions iosOptions = const IOSOptions();
    _storage = FlutterSecureStorage(aOptions: androidOpt, iOptions: iosOptions);
    _checkForFirstLaunch();
  }

  late final FlutterSecureStorage _storage;
  static  SharedPreferenceRef _instance = SharedPreferenceRef._privateConstructor();

  static SharedPreferenceRef get instance => _instance;

  /// To Mock Shared preference services
  /// It only change reference in testing mode only
  static setMockedReference (SharedPreferenceRef mockedRef){
    if(AppUtility.isTestModeActive){
      _instance = mockedRef;
    }
  }

  Future<String> getEmail() async {
    String? value = await _readKey(SharedPrefsKeys.kSPEmail);
    return value ?? "";
  }

  Future<void> setEmail(String value) async {
    await _addKey(SharedPrefsKeys.kSPEmail, value);
  }

  Future<bool> getRememberMeStatus() async {
    String? value = await _readKey(SharedPrefsKeys.kSPRememberMeCheckbox);
    return value == "true";
  }
  Future<void> setRememberMeStatus(bool value) async {
    await _addKey(SharedPrefsKeys.kSPRememberMeCheckbox,value.toString());

  }

  Future<String> getMSBTokenPref() async {
    String? value = await _readKey(SharedPrefsKeys.kSPMsbToken);
    return value ?? "";
  }

  Future<void> setProductTourStatus(String value) async {
    await _addKey(SharedPrefsKeys.kSPTour, value);
  }
  Future<String> getProductTourStatus() async {
    String? value = await _readKey(SharedPrefsKeys.kSPTour);
    return value ?? "";
  }

  setTenantId(String value) {
    return setStringValue(key: SharedPrefsKeys.kSPTenant, value: value);
  }

  setMSBTokenPref(String value) {
    return setStringValue(key: SharedPrefsKeys.kSPMsbToken, value: value);
  }

  Future<String> getLangCode() async {
    String? value = await _readKey(SharedPrefsKeys.kSPLang);
    return value ?? "";
  }

  Future<bool> getBioMetricStatus() async {
    String? value = await _readKey(SharedPrefsKeys.isSecurityShieldOn);
    return value == "true";
  }
  Future<void> setBioMetricStatus(bool value ) async {
    await _addKey(SharedPrefsKeys.isSecurityShieldOn,value.toString());

  }

  Future<bool> getInternalLoginStatus() async {
    String? value = await _readKey(SharedPrefsKeys.kInternalLogin);
    return value == "true";
  }
  Future<void> setInternalLoginStatus(bool value) async {
    return await _addKey(SharedPrefsKeys.kInternalLogin,value.toString());

  }

  Future<String?> getTenantId() async {
    String? value = await _readKey(SharedPrefsKeys.kSPTenant);
    return value ?? "";
  }

  Future<String> getTenantUrl() async {
    String? value = await _readKey(SharedPrefsKeys.kBaseUrl);
    return value ?? ApiUrl.baseUrl;
    /*need to uncomment in case of  unified url */
    /* return value ?? "" */ /* ApiUrl.baseUrl */ /*;*/
  }
  Future<void> setTenantUrl(String value) async {
    return _addKey(SharedPrefsKeys.kBaseUrl,value);
  }

  Future<String> getHostUrl() async {
    String? value = await _readKey(SharedPrefsKeys.kHostUrl);
    /*need to uncomment in case of  unified url */
    return value ?? "" /* ApiUrl.kHostUrl2 */;
  }
  Future<void> setHostUrl(String value) async {
    return _addKey(SharedPrefsKeys.kHostUrl,value);
  }

  @Deprecated(
      "Use getter & setter instead as we don't want to expose storage key to the rest of the app")
  Future<void> setStringValue({String? key, String? value}) async {
    await _addKey(key ?? "", value ?? "");
  }


  // Save list of Favorite users
  Future<void> saveFavoriteUserList({List<String>? value}) async {
    if (value != null) {
      await _addKey(SharedPrefsKeys.kSaveFavUserList, jsonEncode(value));
    }
  }
  Future<List<String>?> getFavoriteUserList() async {
    String? encodedValue = await _readKey(SharedPrefsKeys.kSaveFavUserList);
    if (encodedValue?.isNotEmpty ?? false) {
      List<String>? value = jsonDecode(encodedValue ?? "").cast<String>();
      return value;
    }
    return null;
  }

  /* *************************For Theme *********************************** */

  Future<void> setThemeValue(value) async {
    await _addKey(SharedPrefsKeys.themeMode, value ?? "");
  }

  Future<String?> getThemeValue() async {
    return await _readKey(SharedPrefsKeys.themeMode);
  }

  Future<void> setThemeColor(value) async {
    await _addKey(SharedPrefsKeys.themeColor, value ?? "");
  }

  Future<String?> getThemeColor() async {
    return await _readKey(SharedPrefsKeys.themeColor);
  }
  /* *************************For Theme *********************************** */



  Future<void> setTokenData(String tokenData) async {
    _addKey(SharedPrefsKeys.kTokenData, tokenData);
  }

  Future<void> setProfileData(ProfileInfo profileData) async {
    await _addKey(SharedPrefsKeys.kProfileData, jsonEncode(profileData));
  }

  Future<String?> getTokenData() async {
    String? data = await _readKey(SharedPrefsKeys.kTokenData);
    return data;
  }

  Future<ProfileInfo?> getProfileData() async {
    String? data = await _readKey(SharedPrefsKeys.kProfileData);
    return data != null ? ProfileInfo.fromJson(jsonDecode(data)) : null;
  }

  Future<int?> getImageUploadType() async {
    String? value = await _readKey(SharedPrefsKeys.kImageUploadType);
    return int.tryParse(value ?? "");
  }

  Future<void> setImageUploadType(int value) async {
    await _addKey(SharedPrefsKeys.kImageUploadType, value.toString());
  }

  @Deprecated("Use getter and setter instead")
  Future<void> setBooleanValue({String? key, bool? value}) async {
    await _addKey(key ?? "", value.toString());
  }

  Future<bool> getLaunchAppFirstTime() async {
    String? value = await _readKey(SharedPrefsKeys.kLaunchAppFirstTime);
    return value == "true";
  }
  Future<void> setFirstLaunchSrtatus(bool value) async {
    return _addKey(SharedPrefsKeys.kLaunchAppFirstTime, value.toString());
  }


  Future<String?> getEntityId() async {
    String? value = await _readKey(SharedPrefsKeys.entityId);
    return value;
  }

  Future<void> setEntityId(String value) async {
    await _addKey(SharedPrefsKeys.entityId, value);
  }

  Future<String?> getComposeCount() async {
    String? value = await _readKey(SharedPrefsKeys.composeCount);
    return value;
  }

  Future<void> setComposeCount(String value) async {
    await _addKey(SharedPrefsKeys.composeCount, value);
  }

  //
  Future<void> removeValue({String? key}) async {
    await _deleteKey(key ?? "");
  }

  ///Stores Genius scan license key locally
  Future<String?> getGSLicense() async {
    String? value = await _readKey(SharedPrefsKeys.gsLicense);
    return value;
  }

  Future<void> setGSLicense(String value) async {
    await _addKey(SharedPrefsKeys.gsLicense, value);
  }

  Future<void> deleteGSLicense() async {
    await _deleteKey(SharedPrefsKeys.gsLicense);
  }

  /// Storage CRUD functions

  //Add key
  Future<void> _addKey(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  // Read key
  Future<String?> _readKey(String key) async {
    String? value = await _storage.read(key: key);
    return value;
  }

  Future<String> getBioMetricAuthData() async {
    String? value = await _readKey(SharedPrefsKeys.kBioMetricAuthData);
    return value ?? "";
  }

  Future<void> deleteBioMetricAuthData() async {
    await _deleteKey(SharedPrefsKeys.kBioMetricAuthData);
  }

  Future<void> setBioMetricAuthData(String value) async {
    await _addKey(SharedPrefsKeys.kBioMetricAuthData, value);
  }

  // delete key
  Future<void> _deleteKey(String key) async {
    try {
      return await _storage.delete(key: key);
    } catch (e) {
      print("Exception-->$e");
    }
  }

  // delete all keys
  Future<void> _deleteAllKeys(String key) async {
    return await _storage.deleteAll();
  }

  // Check for first launch
  // if first launch found then clear the storage
  _checkForFirstLaunch() {
    SharedPreferences.getInstance().then((value) {
      bool isFirstLaunch = value.getBool(SharedPrefsKeys.isFirstLaunch) ?? true;
      print("first launch ==> $isFirstLaunch");
      if (isFirstLaunch) {
        _storage.deleteAll();
      }
      value.setBool(SharedPrefsKeys.isFirstLaunch, false);
    });
  }

  Future<String> getBioMetricPopupStatus() async {
    String? value = await _readKey(SharedPrefsKeys.kBioMetricShown);
    return value ?? "false";
  }

  Future<void> setBioMetricPopupStatus(String value) async {
    await _addKey(SharedPrefsKeys.kBioMetricShown, value);
  }



  Future<void> setLastPendingOrder(String isLastPendingOrder) async {
    await _addKey(SharedPrefsKeys.kIsLastPendingOrder, isLastPendingOrder);
  }

  Future<String?> getLastPendingOrder() async {
    String? value = await _readKey(SharedPrefsKeys.kIsLastPendingOrder);
    return value;
  }

}