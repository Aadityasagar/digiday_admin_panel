import 'dart:convert';
import 'dart:io';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/messages.dart';
import 'package:digiday_admin_panel/features/app_session/app_session.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/common/data/api_response.dart';
import 'package:digiday_admin_panel/features/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/connection_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiBaseHelper {
  final AppSessionController _appState = Get.find<AppSessionController>();
  final ConnectionController _networkController = Get.find<ConnectionController>();

  ApiBaseHelper() {
    // HttpOverrides.global = MyHttpOverrides();
  }

  ///Function used to set the [_defaultHeader] in each API
  Future<Map<String, String>> _defaultHeader() async {


    Map<String, String> header = {
      'Content-Type': ApiUrl.kHeaders
    };

    if (_appState?.accessToken != null) {
      header.addAll({
        'auth-token': _appState?.accessToken ?? "",
      });
    }

    return header;
  }

  Future<Map<String, String>> _defaultHeaderWithOutToken() async {
    // todo REPEATED Need to Fix
    Map<String, String> headers1 = {
      "platform": _appState.deviceInfo!["platform"],
      "browser": _appState.deviceInfo!["release"],
      "device": _appState.deviceInfo!["device"]
    };
    Map<String, String> header = {
      "Origin": 'https://${_appState.hostUrl}',
      'Content-Type': ApiUrl.kHeaders,
      'client_details': jsonEncode(headers1),
      'device_id': _appState.deviceId,
    };

    return header;
  }

  ///Common function to send the [get] request
  Future<ApiResponse?>? get({
    required String endPoint,
    Map<String, dynamic>? param,
    Map<String, String>? additionalHeader,
    customResponse = false, String? baseUrl,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = baseUrl ?? ApiUrl.baseUrl;

      //String queryString = '';

      //attaching the headers
      Map<String, String> headers = await _defaultHeader();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }
      // Converting json to query String
      _baseUrl = _baseUrl + endPoint;
      if (param != null) {
        String queryString = Uri(queryParameters: param).query;
        _baseUrl = _baseUrl + "?" + queryString;
      }

      try {
        var response = await http.get(Uri.parse(_baseUrl), headers: headers);
        return await _handleResponse(response, customResponse);
      } on SocketException catch (e) {
      //  debugPrint();
        throw ApiException(message: e.message);
      } on ApiException catch (e) {
        if (e.status == -73) {
          return CommonFunctions.showDialogBox(
            popupType: PopupType.error,
            message: "User is disabled, please contact your system admin",
            actions: [
              ActionButton("Ok".tr, () {
                Get.back();
                CommonFunctions.logoutUser();
                _appState.clearAppState();
              })
            ],
          );
        }
        throw ApiException(message: e.message);
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    } else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
    return null;
  }

  Future<ApiResponse?> getEpakDetailForDeepLinking({
    required String endPoint,
    Map<String, dynamic>? param,
    Map<String, String>? additionalHeader,
    customResponse = false,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = ApiUrl.baseUrl;
      //String queryString = '';

      //attaching the headers
      Map<String, String> headers = await _defaultHeaderWithOutToken();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }
      // Converting json to query String
      _baseUrl = _baseUrl + endPoint;
      if (param != null) {
        String queryString = Uri(queryParameters: param).query;
        _baseUrl = _baseUrl + "?" + queryString;
      }

      try {
        var response = await http.get(Uri.parse(_baseUrl), headers: headers);
        return await _handleResponse(response, customResponse);
      } on SocketException catch (e) {
        throw ApiException(message: "Seems you aren't on correct domain");
      } on ApiException catch (e) {
        if (e.status == -73) {
          return CommonFunctions.showDialogBox(
            popupType: PopupType.error,
            message: "User is disabled, please contact your system admin",
            actions: [
              ActionButton("Ok", () {
                Get.back();
                CommonFunctions.logoutUser();
                _appState.clearAppState();
              })
            ],
          );
        }
        throw ApiException(message: e.message);
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    } else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
  }

  ///Common function to send the [post] request
  Future<ApiResponse?> post({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeader,
    customResponse = false,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = ApiUrl.baseUrl;

      String queryString = '';

      //Setting the headers
      Map<String, String> headers = await _defaultHeader();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }

      // Converting json to query String
      if (param != null) {
        queryString = '?${Uri(queryParameters: param).query}';
      }
      //Final URL
      var requestUrl = _baseUrl + endpoint + queryString;
      try {
        final response = await http.post(
          (Uri.parse(requestUrl)),
          headers: headers,
          body: json.encode(body),
        );
        return await _handleResponse(response, customResponse);
      } on SocketException {
        Get.snackbar("No Connection!", "No internet connection found!");
      } on ApiException catch (e) {
        rethrow;
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    }
    else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
    return null;
  }

  ///Common function to send the [post] request
  Future postMultiPart({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeader,
    customResponse = false,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = ApiUrl.baseUrl;

      String queryString = '';

      //Setting the headers
      Map<String, String> headers = await _defaultHeader();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }

      // Converting json to query String
      if (param != null) {
        queryString = '?${Uri(queryParameters: param).query}';
      }

      //Final URL
      var requestUrl = _baseUrl + endpoint + queryString;
      var request = http.MultipartRequest('POST', (Uri.parse(requestUrl)));
      Map<String, String>? fields =
      body?.map((key, value) => MapEntry(key, value.toString()));
      request.followRedirects = false;
      request.fields.addAll(fields!);
      try {
        http.Response response =
        await http.Response.fromStream(await request.send());

        return await _handleResponse(response, customResponse);
      } on SocketException {
        Get.snackbar("No Connection!", "No internet connection found!");
      } on ApiException catch (e) {
        rethrow;
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    } else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
  }

  Future put({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeader,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = ApiUrl.baseUrl;

      String queryString = '';

      //Setting the headers
      Map<String, String> headers = await _defaultHeader();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }

      // Converting json to query String
      if (param != null) {
        queryString = '?${Uri(queryParameters: param).query}';
      }

      //Final URL
      var requestUrl = _baseUrl + endpoint + queryString;
      try {
        final response = await http.put((Uri.parse(requestUrl)),
            headers: headers, body: json.encode(body));

        return await _handleResponse(response, false);
      } on SocketException {
        Get.snackbar("No Connection!", "No internet connection found!");
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    } else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
  }



  Future patch({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeader,
  }) async {
    if (_networkController.isConnectedToInternet) {
      String _baseUrl = ApiUrl.baseUrl;

      String queryString = '';

      //Setting the headers
      Map<String, String> headers = await _defaultHeader();
      if (additionalHeader != null) {
        headers.addAll(additionalHeader);
      }

      // Converting json to query String
      if (param != null) {
        queryString = '?${Uri(queryParameters: param).query}';
      }

      //Final URL
      var requestUrl = _baseUrl + endpoint + queryString;
      try {
        final response = await http.patch((Uri.parse(requestUrl)),
            headers: headers, body: json.encode(body));

        return await _handleResponse(response, false);
      } on SocketException {
        Get.snackbar("No Connection!", "No internet connection found!");
      } catch (e) {
        throw ApiException(message: AppMessages.somethingWentWrong);
      }
    } else {
      Get.snackbar("No Connection!", "No internet connection found!");
    }
  }

  Future multiPart({
    required String endpoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    required List<File> files,
    String fileKey = "file",
    Map<String, String>? additionalHeader,
  }) async {
    //todo
    String _baseUrl = ApiUrl.baseUrl;
    dynamic responseJson;
    String queryString = '';

    //Setting the headers
    Map<String, String> headers = await _defaultHeader();
    if (additionalHeader != null) {
      headers.addAll(additionalHeader);
    }

    // Converting json to query String
    if (param != null) {
      queryString = '?${Uri(queryParameters: param).query}';
    }

    //Final URL
    var requestUrl = _baseUrl + endpoint + queryString;

    var request = http.MultipartRequest('POST', (Uri.parse(requestUrl)));

    request.files.addAll(List.generate(files.length, (index) {
      String filepath = files[index].path;
      final mimeTypeData =
      lookupMimeType(filepath, headerBytes: [0xFF, 0xD8])?.split('/');

      return http.MultipartFile(
        fileKey,
        files[index].readAsBytes().asStream(),
        files[index].lengthSync(),
        filename: filepath
            .toString()
            .substring(filepath.toString().lastIndexOf("/") + 1),
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
        // contentType: MediaType()
      );
    }));

    request.headers.addAll(headers);
    // http.MultipartRequest().se

    try {
      http.Response response =
      await http.Response.fromStream(await request.send());

      return await _handleResponse(response, false);
    } on SocketException {
      Get.snackbar("No Connection!", "No internet connection found!");
    } catch (e) {
      throw ApiException(message: AppMessages.somethingWentWrong);
    }
  }

  Future delete({
    required String endPoint,
    Map<String, dynamic>? param,
    Map<String, dynamic>? body,
    Map<String, String>? additionalHeader,
  }) async {
    String _baseUrl = ApiUrl.baseUrl;

    String queryString = '';

    //Setting the headers
    Map<String, String> headers = await _defaultHeader();
    if (additionalHeader != null) {
      headers.addAll(additionalHeader);
    }

    // Converting json to query String
    if (param != null) {
      queryString = '?${Uri(queryParameters: param).query}';
    }
    //Final URL
    var requestUrl = _baseUrl + endPoint + queryString;

    try {
      final response = await http.delete(
        (Uri.parse(requestUrl)),
        headers: headers,
        body: json.encode(body),
      );
      return await _handleResponse(response, false);
    } on SocketException catch (e) {
      Get.snackbar("No Connection!", "No internet connection found!");
    } catch (e) {
      throw ApiException(message: AppMessages.somethingWentWrong);
    }
  }

  /// handler Response
  Future<ApiResponse?> _handleResponse(
      http.Response response, bool customResponse,
      {checkForToken = true}) async {
    debugPrint("*******************************************************");
    debugPrint("URL => ${response.request?.url}");
    debugPrint("Header => ${response.request?.headers}");

    debugPrint("*******************************************************\n");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (customResponse) {
        return ApiResponse(data: (jsonDecode(response.body)));
      } else {
        var resp = ApiResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        return resp;
      }
    } else {
      _handleError(response);
      return null;
    }
  }

  /// Handle Network exception
  _handleError(http.Response response) {
    switch (response.statusCode) {
      case 401:
      //todo Refresh code
        throw ApiException(status: 401, message: getErrorMessageForStatus(401));

      case 400:
        var data = jsonDecode(response.body);
        if (data.containsKey("message")) {
          throw ApiException(status: 400, message: data["message"]);
        }
        throw ApiException(status: 400, message: "Something went wrong");
      case 403:
        var data = jsonDecode(response.body);
        throw ApiException(status: data["code"], message: data["message"]);
      default:
        throw ApiException(
            status: response.statusCode,
            message: getErrorMessageForStatus(response.statusCode));
    }
  }

  /// Get error message according to Status [to be used in Future ]
  String getErrorMessageForStatus(int status) {
    String message = "";
    switch (status) {
      case 404:
        message = "Invalid URL";
        break;
      default:
        message = "Something went wrong";
    }
    return message;
  }

  /// Download file
  Future<Uint8List> downloadFile(String url,
      {Map<String, String>? additionalHeader}) async {
    //todo try catch

    Map<String, String> headers = await _defaultHeader();
    if (additionalHeader != null) {
      headers.addAll(additionalHeader);
    }
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var bytes = response.bodyBytes;
      if (response.headers.containsKey("accept-ranges")) {
        return bytes;
      } else {
        throw ApiException(
            message: "Document not found", status: ApiExceptionCode.noDocument);
      }
    } else {
      throw ApiException(message: "Failed to download  file ");
    }
  }

  /// On Session Expire  Logout user
  Future<void> onSessionExpire() async {
    // await CommonFunctions.showDialogBox(
    //   popupType: PopupType.error,
    //   message: "Session Expire",
    //   actions: [
    //     ActionButton(LocalizationKey.kokBtn.tr, () {
    //       Get.back();
    //     })
    //   ],
    // );



    CommonFunctions.showSnackBar(
      // todo translate
        title: "Warning",
        message: "Session Expired",
        type: PopupType.error);
    CommonFunctions.logoutUser();
    _appState.clearAppState();
  }


}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}