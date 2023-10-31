import 'dart:convert';

import 'package:digiday_admin_panel/features/subscriptions/controllers/subscription_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaytmWebView extends StatelessWidget {
   PaytmWebView({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {

    final SubscriptionController _subscriptionController=Get.find<SubscriptionController>();

    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://securegw.paytm.in/theia/processTransaction"),
              method: 'POST',
              body: Uint8List.fromList(utf8.encode(_subscriptionController.queryString!)),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
              }
          ),


          onLoadStop: (controller, url) async {
            if(url.toString().contains("pgResponse")==true){
              final response = await controller.evaluateJavascript(source: "document.documentElement.innerText");
              if(response!=null){
                _subscriptionController.processResponse(response);
              }
            }
          },
          onLoadError: (controller, url, code, message) {
            print(url);
          },
          onWebViewCreated: (controller) {

          },
        ),
      ),
    );
  }
}
