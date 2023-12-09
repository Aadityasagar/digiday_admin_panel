import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CmDetailsScreen extends StatelessWidget {
  CmDetailsScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<CmProvider>(
        builder: (context,cmProvider,child) {
          return Stack(
            children: [
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: const ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopCmDetailsScreen(),
                  smallScreen: getMobileCmDetailsScreen(context),
                  mediumScreen: getTabCmDetailsScreen(context),
                ),
              ),
              Offstage(
                  offstage: !cmProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}

Widget getMobileCmDetailsScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// image

            Center(
              child: cmProvider.selectedCm?.photo==null ? const Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/ProfileImage.png"),
                  radius: 120,
                ),
              ):
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                    radius: 120,
                  )
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// name

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Name",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                      ),
                    ),
                  ],
                ),

                /// email

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Email:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.email ?? "",
                      ),
                    ),
                  ],
                ),

                /// email verified

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Email Verified:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.emailVerified==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

                /// phone

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Phone:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.phone ?? "",
                      ),
                    ),
                  ],
                ),

                /// Phone verified

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Phone Verified:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.phoneVerified==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

                /// address

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Address:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.address ?? "",
                      ),
                    ),
                  ],
                ),

                /// city

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("City:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.city ?? "",
                      ),
                    ),
                  ],
                ),

                /// state

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("State:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.state ?? "",
                      ),
                    ),
                  ],
                ),

                /// Pin-code

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Pin-Code:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.pinCode ?? "",
                      ),
                    ),
                  ],
                ),

                /// referral code

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Referral Code:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.referralCode ?? "",
                      ),
                    ),
                  ],
                ),

                /// referred by

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Referred By:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.referredBy ?? "",
                      ),
                    ),
                  ],
                ),

                /// isSubscribed

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Is Subscriber:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.isSubscribed==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    ):const Text("No Cm selected!");
  });
}

Widget getTabCmDetailsScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// image

            Center(
              child: cmProvider.selectedCm?.photo==null ? const Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/ProfileImage.png"),
                  radius: 120,
                ),
              ):
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                    radius: 120,
                  )
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// name

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Name",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                      ),
                    ),
                  ],
                ),

                /// email

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Email:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.email ?? "",
                      ),
                    ),
                  ],
                ),

                /// email verified

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Email Verified:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.emailVerified==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

                /// phone

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Phone:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.phone ?? "",
                      ),
                    ),
                  ],
                ),

                /// Phone verified

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Phone Verified:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.phoneVerified==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

                /// address

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Address:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.address ?? "",
                      ),
                    ),
                  ],
                ),

                /// city

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("City:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.city ?? "",
                      ),
                    ),
                  ],
                ),

                /// state

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("State:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.state ?? "",
                      ),
                    ),
                  ],
                ),

                /// Pin-code

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Pin-Code:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.pinCode ?? "",
                      ),
                    ),
                  ],
                ),

                /// referral code

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Referral Code:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.referralCode ?? "",
                      ),
                    ),
                  ],
                ),

                /// referred by

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Referred By:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm?.referredBy ?? "",
                      ),
                    ),
                  ],
                ),

                /// isSubscribed

                Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Is Subscriber:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        cmProvider.selectedCm!.isSubscribed==true? "Yes":
                        "No",
                      ),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
      ),
    ):const Text("No Cm selected!");
  });
}

Widget getDesktopCmDetailsScreen() {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
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
                        /// image

                        Center(
                          child: cmProvider.selectedCm?.photo==null ? const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/ProfileImage.png"),
                              radius: 120,
                            ),
                          ):
                          Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                                radius: 120,
                              )
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// name

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Name",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                                  ),
                                ),
                              ],
                            ),

                            /// email

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Email:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.email ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// email verified

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Email Verified:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm!.emailVerified==true? "Yes":
                                    "No",
                                  ),
                                ),
                              ],
                            ),

                            /// phone

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Phone:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.phone ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// Phone verified

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Phone Verified:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm!.phoneVerified==true? "Yes":
                                    "No",
                                  ),
                                ),
                              ],
                            ),

                            /// address

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Address:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.address ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// city

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("City:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.city ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// state

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("State:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.state ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// Pin-code

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Pin-Code:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.pinCode ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// referral code

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Referral Code:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.referralCode ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// referred by

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Referred By:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm?.referredBy ?? "",
                                  ),
                                ),
                              ],
                            ),

                            /// isSubscribed

                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("Is Subscriber:",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    cmProvider.selectedCm!.isSubscribed==true? "Yes":
                                    "No",
                                  ),
                                ),
                              ],
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
    ):const Text("No Product selected!");
  });
}
