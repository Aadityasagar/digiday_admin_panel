import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/models/user_model.dart';
import 'package:digiday_admin_panel/provider/vendors_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VendorDetailsScreen extends StatelessWidget {
  UserData? selectedVendor;

  VendorDetailsScreen({super.key,
  required this.selectedVendor
  });

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
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
              largeScreen: getDesktopVendorDetailsScreen(selectedVendor),
              smallScreen: getMobileVendorDetailsScreen(context, selectedVendor),
              mediumScreen: getTabVendorDetailsScreen(context, selectedVendor),
            ),
          ),
          Offstage(
              offstage: !vendorProvider.isLoading,
              child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileVendorDetailsScreen(BuildContext context, UserData? selectedVendor) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return selectedVendor != null
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
                            child: selectedVendor?.photo ==
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
                                      selectedVendor
                                          ?.photo ??
                                          ""),
                                  radius: 60,
                                )),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            '${selectedVendor?.firstName} ${selectedVendor?.lastName}',
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
                              "${selectedVendor?.address ?? ""} ${selectedVendor?.city ?? ""}"),

                          Text("Business Name : Purjay"),

                          /// subscription status

                          const SizedBox(
                            height: 10,
                          ),

                          selectedVendor!.userSubscriptionStatus == 'active'
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
                                      "Vendor is subscribed to ${selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "₹${selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "This pack is valid for ${selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "Last recharge done on ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "Next recharge date ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
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

                  selectedVendor!.userSubscriptionStatus ==
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
                                  selectedVendor!
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
                                selectedVendor!.emailVerified ==
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
                                selectedVendor!.phoneVerified ==
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
                                        '${selectedVendor?.firstName}',
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
                                        selectedVendor?.email ??
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
                                        selectedVendor?.referredBy ??
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
                                        '${selectedVendor?.lastName}',
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
                                        selectedVendor?.phone ??
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

                                  /// business name

                                  Row(
                                    children: [
                                      Text(
                                        'Store Name:',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                35,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Purjay Estore",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                35,
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
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
        : const Text("No Vendor selected!");
  });
}

Widget getTabVendorDetailsScreen(BuildContext context, UserData? selectedVendor) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return selectedVendor != null
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
                      child: selectedVendor?.photo ==
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
                                selectedVendor
                                    ?.photo ??
                                    ""),
                            radius: 60,
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      '${selectedVendor?.firstName} ${selectedVendor?.lastName}',
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
                        "${selectedVendor?.address ?? ""} ${selectedVendor?.city ?? ""}"),

                    Text("Business Name : Purjay"),

                    /// subscription status

                    const SizedBox(
                      height: 10,
                    ),

                    vendorProvider.selectedVendor!.userSubscriptionStatus == 'active'
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
                                "Vendor is subscribed to ${selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "₹${selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "This pack is valid for ${selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Last recharge done on ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  "Next recharge date ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
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

            selectedVendor!.userSubscriptionStatus ==
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
                      selectedVendor!
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
                          selectedVendor!.emailVerified ==
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
                          selectedVendor!.phoneVerified ==
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
                                  '${selectedVendor?.firstName}',
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
                                  selectedVendor?.email ??
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
                                  selectedVendor?.referredBy ??
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
                                  '${selectedVendor?.lastName}',
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
                                  selectedVendor?.phone ??
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

                            /// business name

                            Row(
                              children: [
                                Text(
                                  'Store Name:',
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Purjay Estore",
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .width /
                                          35,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
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
        : const Text("No Vendor selected!");
  });
}

Widget getDesktopVendorDetailsScreen(UserData? selectedVendor) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return selectedVendor != null
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
                                        child: selectedVendor?.photo ==
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
                                                      selectedVendor
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
                                        '${selectedVendor?.firstName} ${selectedVendor?.lastName}',
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
                                              "${selectedVendor?.address ?? ""} ${selectedVendor?.city ?? ""}"),
                                        ],
                                      ),

                                      /// subscription status

                                      const Row(
                                        children: [
                                          Icon(Icons.storefront_sharp),
                                          Text("Purjay"),
                                        ],
                                      ),

                                      selectedVendor!.userSubscriptionStatus == 'active'
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
                                                  "Vendor is subscribed to ${selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  "₹${selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.white),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Text(
                                                    "This pack is valid for ${selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Text(
                                                    "Last recharge done on ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Text(
                                                    "Next recharge date ${DateFormat.yMMMEd().format(selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
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
                                              title: "Orders",
                                              count: "${vendorProvider.vendorOrders.length}",),
                                          ActionsCard(
                                              title: "Products",
                                              count: "${vendorProvider.vendorsProducts.length}",),
                                          ActionsCard(
                                              title: "Wallet Balance",
                                              count: "₹${vendorProvider.currentVendorWalletBalance.value}",),
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
                                            'Vendors Details',
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
                                                        '${selectedVendor?.firstName}',
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
                                                        selectedVendor
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
                                                        selectedVendor
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
                                                        '${selectedVendor?.lastName}',
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
                                                        selectedVendor
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

                                                  /// business name

                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Store Name:',
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
                                                        "Purjay Estore",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width /
                                                                90,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
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

                          selectedVendor!.userSubscriptionStatus ==
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
                                              selectedVendor!
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
                                                    vendorProvider
                                                                .selectedVendor!
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
                                                    selectedVendor!
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
                                              selectedVendor!
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
                                              selectedVendor!
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
        : const Text("No Vendor selected!");
  });
}


class ActionsCard extends StatelessWidget {
  const ActionsCard({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Container(
          width: ResponsiveWidget.isMediumScreen(context)
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 8,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(
                  count!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: ResponsiveWidget.isLargeScreen(context)
                          ? MediaQuery.of(context).size.width / 40
                          : MediaQuery.of(context).size.width / 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: ResponsiveWidget.isLargeScreen(context)
                          ? MediaQuery.of(context).size.width / 80
                          : MediaQuery.of(context).size.width / 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}