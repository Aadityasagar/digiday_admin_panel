import 'dart:convert';
import 'dart:io';
import 'package:digiday_admin_panel/constants/app_urls.dart';
import 'package:digiday_admin_panel/constants/messages.dart';
import 'package:digiday_admin_panel/screens/common/common_functions.dart';
import 'package:digiday_admin_panel/models/api_response.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/single_button_popup.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:digiday_admin_panel/utils/services/network/connection_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiBaseHelper {
  final ConnectionController _networkController = Get.find<ConnectionController>();


  ///Function used to set the [_defaultHeader] in each API
  Future<Map<String, String>> _defaultHeader() async {


    Map<String, String> header = {
      'Content-Type': ApiUrl.kHeaders
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
                //CommonFunctions.logoutUser();
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




}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}