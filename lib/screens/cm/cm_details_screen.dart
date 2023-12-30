import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/screens/vendor/vendor_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CmDetailsScreen extends StatelessWidget {
  UserData? selectedCm;

  CmDetailsScreen({super.key,
  required this.selectedCm
  });

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<CmProvider>(builder: (context, cmProvider, child) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: ColourScheme.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: HeaderWidget(opacity: _opacity),
            ),
            drawer: const ExploreDrawer(),
            body: ResponsiveWidget(
              largeScreen: getDesktopCmDetailsScreen(selectedCm),
              smallScreen: getMobileCmDetailsScreen(context, selectedCm),
              mediumScreen: getTabCmDetailsScreen(context, selectedCm),
            ),
          ),
          Offstage(
              offstage: !cmProvider.isLoading, child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileCmDetailsScreen(BuildContext context, UserData? selectedCm) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return selectedCm != null
        ? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    /// image

                    Center(
                      child:
                          selectedCm?.photo ==
                          null
                          ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/ProfileImage.png"),
                          radius: 60,
                        ),
                      )
                          : Padding(
                          padding:
                          const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                selectedCm
                                    ?.photo ??
                                    ""),
                            radius: 60,
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      '${selectedCm?.firstName} ${selectedCm?.lastName}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),

                    /// name

                    const SizedBox(
                      height: 10,
                    ),

                    /// address

                    Text(
                        "${selectedCm?.address ?? ""} ${selectedCm?.city ?? ""}"),


                    /// subscription status

                    const SizedBox(
                      height: 10,
                    ),

                    selectedCm!.userSubscriptionStatus == 'active'
                        ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                "CM is subscribed to ${selectedCm!.subscription?.planDetails?.name ?? ""}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "₹${selectedCm!.subscription?.planDetails?.rate ?? ""}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "This pack is valid for ${selectedCm!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Last recharge done on ${DateFormat.yMMMEd().format(selectedCm!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Next recharge date ${DateFormat.yMMMEd().format(selectedCm!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox()


                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// subscription info

            selectedCm!.userSubscriptionStatus ==
                'inactive'
                ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Is Subscriber:",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width /
                              35,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      selectedCm!
                          .userSubscriptionStatus ==
                          'active'
                          ? "Yes"
                          : "No",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width /
                              35,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),

            const SizedBox(height: 15),

            /// verifications

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// email verified

                    Row(
                      children: [
                        Text(
                          "Email Verified:",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedCm!.emailVerified ==
                              true
                              ? "Yes"
                              : "No",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    /// Phone verified

                    Row(
                      children: [
                        Text(
                          "Phone Verified:",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedCm!.phoneVerified ==
                              true
                              ? "Yes"
                              : "No",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 22),
                child: Column(
                  children: [
                    Text(
                      'CM Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                          MediaQuery.of(context).size.width / 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// first name
                            Row(
                              children: [
                                Text(
                                  'First Name:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${selectedCm?.firstName}',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// email
                            Row(
                              children: [
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedCm?.email ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// referred by

                            Row(
                              children: [
                                Text(
                                  'Referred By:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedCm?.referredBy ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// last name

                            Row(
                              children: [
                                Text(
                                  'Last Name:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${selectedCm?.lastName}',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// phone

                            Row(
                              children: [
                                Text(
                                  'Phone:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedCm?.phone ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    )
        : const Text("No Cm selected!");
  });
}

Widget getTabCmDetailsScreen(BuildContext context, UserData? selectedCm) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return selectedCm != null
        ? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    /// image

                    Center(
                      child: selectedCm?.photo ==
                          null
                          ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/ProfileImage.png"),
                          radius: 60,
                        ),
                      )
                          : Padding(
                          padding:
                          const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                               selectedCm
                                    ?.photo ??
                                    ""),
                            radius: 60,
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      '${selectedCm?.firstName} ${selectedCm?.lastName}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),

                    /// name

                    const SizedBox(
                      height: 10,
                    ),

                    /// address

                    Text(
                        "${selectedCm?.address ?? ""} ${selectedCm?.city ?? ""}"),


                    /// subscription status

                    const SizedBox(
                      height: 10,
                    ),

                    selectedCm!.userSubscriptionStatus == 'active'
                        ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                "CM is subscribed to ${selectedCm!.subscription?.planDetails?.name ?? ""}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "₹${selectedCm!.subscription?.planDetails?.rate ?? ""}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "This pack is valid for ${selectedCm!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Last recharge done on ${DateFormat.yMMMEd().format(selectedCm!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Next recharge date ${DateFormat.yMMMEd().format(selectedCm!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox()


                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// subscription info

            selectedCm!.userSubscriptionStatus ==
                'inactive'
                ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Is Subscriber:",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width /
                              35,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      selectedCm!
                          .userSubscriptionStatus ==
                          'active'
                          ? "Yes"
                          : "No",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.width /
                              35,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),

            const SizedBox(height: 15),

            /// verifications

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// email verified

                    Row(
                      children: [
                        Text(
                          "Email Verified:",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedCm!.emailVerified ==
                              true
                              ? "Yes"
                              : "No",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    /// Phone verified

                    Row(
                      children: [
                        Text(
                          "Phone Verified:",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          selectedCm!.phoneVerified ==
                              true
                              ? "Yes"
                              : "No",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 22),
                child: Column(
                  children: [
                    Text(
                      'Vendors Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                          MediaQuery.of(context).size.width / 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// first name
                            Row(
                              children: [
                                Text(
                                  'First Name:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${selectedCm?.firstName}',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// email
                            Row(
                              children: [
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(selectedCm?.email ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// referred by

                            Row(
                              children: [
                                Text(
                                  'Referred By:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedCm?.referredBy ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// last name

                            Row(
                              children: [
                                Text(
                                  'Last Name:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${selectedCm?.lastName}',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            /// phone

                            Row(
                              children: [
                                Text(
                                  'Phone:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedCm?.phone ??
                                      "",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    )
        : const Text("No Cm selected!");
  });
}

Widget getDesktopCmDetailsScreen(UserData? selectedCm) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return selectedCm != null
        ? SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// sidebar

                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height,
                  child: const SideBarMenu(),
                ),

                const SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            /// image container

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                child: Column(
                                  children: [
                                    /// image

                                    Center(
                                      child: selectedCm?.photo ==
                                          null
                                          ? const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/ProfileImage.png"),
                                          radius: 60,
                                        ),
                                      )
                                          : Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                selectedCm
                                                    ?.photo ??
                                                    ""),
                                            radius: 60,
                                          )),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    /// name

                                    Text(
                                      '${selectedCm?.firstName} ${selectedCm?.lastName}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),
                                    ),

                                    /// address

                                    Row(
                                      children: [
                                        const Icon(
                                            CupertinoIcons.location_solid),
                                        Text(
                                            "${selectedCm?.address ?? ""} ${selectedCm?.city ?? "Address Not Available"}"),
                                      ],
                                    ),

                                    /// subscription status


                                    selectedCm!.userSubscriptionStatus == 'active'
                                        ? Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.black),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                "CM is subscribed to ${selectedCm!.subscription?.planDetails?.name ?? ""}",
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "₹${selectedCm!.subscription?.planDetails?.rate ?? ""}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Text(
                                                  "This pack is valid for ${selectedCm!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Text(
                                                  "Last recharge done on ${DateFormat.yMMMEd().format(selectedCm!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: Text(
                                                  "Next recharge date ${DateFormat.yMMMEd().format(selectedCm!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ) : SizedBox()


                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),

                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/1.8,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Colors.white),
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80.0, vertical: 20),
                                    child: Row(
                                      children: [
                                        ActionsCard(
                                          title: "My CM Team",
                                          count: "${cmProvider.myCmTeamMates.length}",),
                                        ActionsCard(
                                          title: "My Vendor Team",
                                          count: "${cmProvider.myVendorTeamMates.length}",),
                                        ActionsCard(
                                          title: "Wallet Balance",
                                          count: "₹${cmProvider.currentCmWalletBalance.value}",),
                                      ],
                                    ),
                                  ),
                                ),



                                const SizedBox(height: 10),

                                Container(
                                  width: MediaQuery.of(context).size.width/1.8,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 22),
                                    child: Column(
                                      children: [
                                        Text(
                                          'CM Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  60),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                /// first name
                                                Row(
                                                  children: [
                                                    Text(
                                                      'First Name:',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    const SizedBox(
                                                        width: 5),
                                                    Text(
                                                      '${selectedCm?.firstName}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                /// email
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Email:',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    const SizedBox(
                                                        width: 5),
                                                    Text(
                                                      selectedCm
                                                          ?.email ??
                                                          "",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                /// referred by

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Referred By:',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    const SizedBox(
                                                        width: 5),
                                                    Text(
                                                      selectedCm
                                                          ?.referredBy ??
                                                          "Self Registered",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                /// last name

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Last Name:',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    const SizedBox(
                                                        width: 5),
                                                    Text(
                                                      '${selectedCm?.lastName}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                /// phone

                                                Row(
                                                  children: [
                                                    Text(
                                                      'Phone:',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600),
                                                    ),
                                                    const SizedBox(
                                                        width: 5),
                                                    Text(
                                                      selectedCm
                                                          ?.phone ??
                                                          "Not Available",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              90,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),

                        /// subscription info

                        selectedCm!.userSubscriptionStatus ==
                            'inactive'
                            ? Row(
                          children: [
                            /// subscriber or not

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 75, vertical: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Is Subscriber:",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      selectedCm!
                                          .userSubscriptionStatus ==
                                          'active'
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            /// verifications

                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      /// email verified

                                      Row(
                                        children: [
                                          Text(
                                            "Email Verified:",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    90,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            selectedCm!
                                                .emailVerified ==
                                                true
                                                ? "Yes"
                                                : "No",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    90,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ],
                                      ),

                                      /// Phone verified

                                      Row(
                                        children: [
                                          Text(
                                            "Phone Verified:",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    90,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            selectedCm!
                                                .phoneVerified ==
                                                true
                                                ? "Yes"
                                                : "No",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width /
                                                    90,
                                                fontWeight:
                                                FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                /// email verified

                                Row(
                                  children: [
                                    Text(
                                      "Email Verified:",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      selectedCm!
                                          .emailVerified ==
                                          true
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),

                                /// Phone verified

                                Row(
                                  children: [
                                    Text(
                                      "Phone Verified:",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      selectedCm!
                                          .phoneVerified ==
                                          true
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              90,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),



                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    )
        : const Text("No CM selected!");
  });
}
