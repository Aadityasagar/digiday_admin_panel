import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/account_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {

  double _opacity = 0;
  final double _scrollPosition = 0;

  ProfileScreen({super.key});

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
                backgroundColor:  ColourScheme.backgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: const ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopProfileScreen(),
                  smallScreen: getMobileProfileScreen(context),
                  mediumScreen: getTabProfileScreen(context),
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



Widget getMobileProfileScreen(BuildContext context) {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [

                    const SizedBox(height: 10,),
                    /// image

                    Center(
                      child: accountProvider.getCurrentUser?.photo==null ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                          radius: 150,
                        ),
                      ):
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(accountProvider.getCurrentUser?.photo ?? ""),
                            radius: 150,
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    /// name

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),
                        Text(
                          '${accountProvider.getCurrentUser?.firstName} ${accountProvider.getCurrentUser?.lastName}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// email
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          accountProvider.getCurrentUser?.email ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// phone

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          accountProvider.getCurrentUser?.phone ?? "",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// Referral Code

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(accountProvider.getCurrentUser?.referralCode?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),
                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getTabProfileScreen(BuildContext context) {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 10,),
                    /// image

                    Center(
                      child: accountProvider.getCurrentUser?.photo==null ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                          radius: 150,
                        ),
                      ):
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(accountProvider.getCurrentUser?.photo ?? ""),
                            radius: 150,
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    /// name

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),
                        Text(
                          '${accountProvider.getCurrentUser?.firstName} ${accountProvider.getCurrentUser?.lastName}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// email
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          accountProvider.getCurrentUser?.email ?? "",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// phone

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          accountProvider.getCurrentUser?.phone ?? "",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    /// Referral Code

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(accountProvider.getCurrentUser?.referralCode?? "",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),


                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopProfileScreen() {
  return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// blank space

                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height,

                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My profile",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 23,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            /// image container

                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                                child: Column(children: [
                                  /// image

                                  Center(
                                    child: accountProvider.getCurrentUser?.photo==null ? const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                                        radius: 180,
                                      ),
                                    ):
                                    Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(accountProvider.getCurrentUser?.photo ?? ""),
                                          radius: 180,
                                        )
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  /// name

                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600),
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        '${accountProvider.getCurrentUser?.firstName} ${accountProvider.getCurrentUser?.lastName}',
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10,),

                                  /// email
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600),
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        accountProvider.getCurrentUser?.email ?? "",
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10,),

                                  /// phone

                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600),
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        accountProvider.getCurrentUser?.phone ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10,),

                                  /// Referral Code

                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w600),
                                      ),

                                      const SizedBox(width: 5),

                                      Text(accountProvider.getCurrentUser?.referralCode?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                          fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10,),

                                ],),
                              ),
                            ),
                          ],
                        )
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
