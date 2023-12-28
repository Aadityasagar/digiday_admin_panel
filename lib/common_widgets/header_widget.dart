import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/account_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  final double opacity;

  const HeaderWidget({Key? key, required this.opacity}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.1,
      child: ResponsiveWidget(
        largeScreen: getDesktopAppbar(),
        smallScreen: getMobileAppbar(),
        mediumScreen: getTabAppbar(),
      ),
    );
  }

  Widget getMobileAppbar() {
    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(
                  "assets/images/logo-rec.png",
                  height: 60,
                )),
            Row(
              children: [
                accountProvider.getCurrentUser?.photo == null
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profileScreen);
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ProfileImage.png"),
                        ),
                      )
                    : accountProvider.profilePicUrl != ""
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.profileScreen);
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(accountProvider.profilePicUrl),
                            ),
                          )
                        : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${accountProvider.getCurrentUser?.firstName ?? ""} ${accountProvider.getCurrentUser?.lastName ?? ""}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  CupertinoIcons.bell_fill,
                  color: kPrimaryColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),

              ],
            )
          ],
        ),
      );
    });
  }

  Widget getTabAppbar() {
    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                  child: Image.asset(
                    "assets/images/logo-rec.png",
                    height: 60,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                accountProvider.getCurrentUser?.photo == null
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profileScreen);
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ProfileImage.png"),
                        ),
                      )
                    : accountProvider.profilePicUrl != ""
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.profileScreen);
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(accountProvider.profilePicUrl),
                            ),
                          )
                        : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${accountProvider.getCurrentUser?.firstName ?? ""} ${accountProvider.getCurrentUser?.lastName ?? ""}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  CupertinoIcons.bell_fill,
                  color: kPrimaryColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.logout,
                  color: kPrimaryColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget getDesktopAppbar() {
    return Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/logo-rec.png",
                  height: 60,
                ),
              ],
            ),
            Row(
              children: [
                accountProvider.getCurrentUser?.photo == null
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.profileScreen);
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/ProfileImage.png"),
                        ),
                      )
                    : accountProvider.profilePicUrl != ""
                        ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.profileScreen);
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(accountProvider.profilePicUrl),
                            ),
                          )
                        : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${accountProvider.getCurrentUser?.firstName ?? ""} ${accountProvider.getCurrentUser?.lastName ?? ""}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  CupertinoIcons.bell_fill,
                  color: kPrimaryColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.logout,
                  color: kPrimaryColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
