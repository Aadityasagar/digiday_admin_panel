import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/provider/account_provider.dart';
import 'package:digiday_admin_panel/screens/account/view/components/profile_pic.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Consumer<AccountProvider>(
        builder: (context,accountProvider,child) {
          return Stack(
            children: [
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                body: ResponsiveWidget(
                  largeScreen: getDesktopCmScreen(),
                  smallScreen: getMobileCmScreen(context),
                  mediumScreen: getTabCmScreen(context),
                ),
              ),
              Offstage(
                  offstage: !accountProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}



Widget getMobileCmScreen(BuildContext context) {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfilePic(),
          ],
        ),
      ),
    );
  });
}

Widget getTabCmScreen(BuildContext context) {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfilePic(),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopCmScreen() {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// blank space

                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfilePic(),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  });
}
