import 'package:digiday_admin_panel/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Terms & conditions",style: subHeadingStyle,),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse("https://digidayapp.serveravatartmp.com/terms-and-conditions.html"),
          ),
          onLoadStop: (controller, url) async {
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
