import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/vendors_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VendorDetailsScreen extends StatelessWidget {
  VendorDetailsScreen({super.key});

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
              largeScreen: getDesktopVendorDetailsScreen(),
              smallScreen: getMobileVendorDetailsScreen(context),
              mediumScreen: getTabVendorDetailsScreen(context),
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

Widget getMobileVendorDetailsScreen(BuildContext context) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return vendorProvider.selectedVendor != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),

                          /// image

                          Center(
                            child: vendorProvider.selectedVendor?.photo == null
                                ? const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/ProfileImage.png"),
                                      radius: 100,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          vendorProvider
                                                  .selectedVendor?.photo ??
                                              ""),
                                      radius: 100,
                                    )),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          /// name

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.person),
                              Text(
                                '${vendorProvider.selectedVendor?.firstName} ${vendorProvider.selectedVendor?.lastName}',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          /// address

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CupertinoIcons.location_solid),
                              Text(
                                "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""}",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          /// business name

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.storefront_sharp),
                              Text(
                                "Purjay",
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

                  /// subscription info

                  vendorProvider.selectedVendor!.userSubscriptionStatus ==
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
                                  vendorProvider.selectedVendor!
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

                  vendorProvider.selectedVendor!.userSubscriptionStatus ==
                          'active'
                      ? Container(width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Column(
                              children: [
                                Text(
                                  "Vendor is subscribed to ${vendorProvider.selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "₹${vendorProvider.selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "This pack is valid for ${vendorProvider.selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "Last recharge done on ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "Next recharge date ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
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
                                vendorProvider.selectedVendor!.emailVerified ==
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
                                vendorProvider.selectedVendor!.phoneVerified ==
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
                                        '${vendorProvider.selectedVendor?.firstName}',
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
                                        vendorProvider.selectedVendor?.email ??
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
                                        vendorProvider
                                                .selectedVendor?.referredBy ??
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
                                        '${vendorProvider.selectedVendor?.lastName}',
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
                                        vendorProvider.selectedVendor?.phone ??
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

                  /// address

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""} ${vendorProvider.selectedVendor?.state ?? ""} ${vendorProvider.selectedVendor?.pinCode ?? ""}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 35,
                                fontWeight: FontWeight.w400),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
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

Widget getTabVendorDetailsScreen(BuildContext context) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return vendorProvider.selectedVendor != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),

                          /// image

                          Center(
                            child: vendorProvider.selectedVendor?.photo == null
                                ? const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/ProfileImage.png"),
                                      radius: 100,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          vendorProvider
                                                  .selectedVendor?.photo ??
                                              ""),
                                      radius: 100,
                                    )),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          /// name

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.person),
                              Text(
                                '${vendorProvider.selectedVendor?.firstName} ${vendorProvider.selectedVendor?.lastName}',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 50,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          /// address

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(CupertinoIcons.location_solid),
                              Text(
                                "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""}",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 50,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          /// business name

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.storefront_sharp),
                              Text(
                                "Purjay",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 50,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  vendorProvider.selectedVendor!.userSubscriptionStatus ==
                          'active'
                      ? Container(width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: Column(
                              children: [
                                Text(
                                  "Vendor is subscribed to ${vendorProvider.selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "₹${vendorProvider.selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "This pack is valid for ${vendorProvider.selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "Last recharge done on ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "Next recharge date ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),

                  const SizedBox(height: 15),

                  /// subscription info

                  vendorProvider.selectedVendor!.userSubscriptionStatus ==
                          'inactive'
                      ? Row(
                          children: [
                            /// subscriber or not

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 75, vertical: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Is Subscriber:",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      vendorProvider.selectedVendor!
                                                  .userSubscriptionStatus ==
                                              'active'
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            vendorProvider.selectedVendor!
                                                        .emailVerified ==
                                                    true
                                                ? "Yes"
                                                : "No",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            vendorProvider.selectedVendor!
                                                        .phoneVerified ==
                                                    true
                                                ? "Yes"
                                                : "No",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50,
                                                fontWeight: FontWeight.w400),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// email verified

                                Row(
                                  children: [
                                    Text(
                                      "Email Verified:",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      vendorProvider.selectedVendor!
                                                  .emailVerified ==
                                              true
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      vendorProvider.selectedVendor!
                                                  .phoneVerified ==
                                              true
                                          ? "Yes"
                                          : "No",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50,
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
                                    MediaQuery.of(context).size.width / 45),
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${vendorProvider.selectedVendor?.firstName}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        vendorProvider.selectedVendor?.email ??
                                            "",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        vendorProvider
                                                .selectedVendor?.referredBy ??
                                            "",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${vendorProvider.selectedVendor?.lastName}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        vendorProvider.selectedVendor?.phone ??
                                            "",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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
                                                50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Purjay Estore",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                50,
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

                  /// address

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 50,
                                fontWeight: FontWeight.w600),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""} ${vendorProvider.selectedVendor?.state ?? ""} ${vendorProvider.selectedVendor?.pinCode ?? ""}",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 50,
                                fontWeight: FontWeight.w400),
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

Widget getDesktopVendorDetailsScreen() {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return vendorProvider.selectedVendor != null
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
                                        child: vendorProvider
                                                    .selectedVendor?.photo ==
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
                                                      vendorProvider
                                                              .selectedVendor
                                                              ?.photo ??
                                                          ""),
                                                  radius: 60,
                                                )),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      /// name

                                      Row(
                                        children: [
                                          const Icon(Icons.person),
                                          Text(
                                            '${vendorProvider.selectedVendor?.firstName} ${vendorProvider.selectedVendor?.lastName}',
                                          ),
                                        ],
                                      ),

                                      /// address

                                      Row(
                                        children: [
                                          const Icon(
                                              CupertinoIcons.location_solid),
                                          Text(
                                              "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""}"),
                                        ],
                                      ),

                                      /// business name

                                      const Row(
                                        children: [
                                          Icon(Icons.storefront_sharp),
                                          Text("Purjay"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),

                              Expanded(
                                child: Column(
                                  children: [

                                    vendorProvider
                                        .selectedVendor!.userSubscriptionStatus ==
                                        'active'
                                        ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.black),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 120),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Vendor is subscribed to ${vendorProvider.selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "₹${vendorProvider.selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                              style: const TextStyle(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(
                                                "This pack is valid for ${vendorProvider.selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(
                                                "Last recharge done on ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text(
                                                "Next recharge date ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(
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
                                                          '${vendorProvider.selectedVendor?.firstName}',
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
                                                          vendorProvider
                                                              .selectedVendor
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
                                                          vendorProvider
                                                              .selectedVendor
                                                              ?.referredBy ??
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
                                                          '${vendorProvider.selectedVendor?.lastName}',
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
                                                          vendorProvider
                                                              .selectedVendor
                                                              ?.phone ??
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



                                    const SizedBox(height: 10),

                                    /// address

                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Address:',
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
                                              "${vendorProvider.selectedVendor?.address ?? ""} ${vendorProvider.selectedVendor?.city ?? ""} ${vendorProvider.selectedVendor?.state ?? ""} ${vendorProvider.selectedVendor?.pinCode ?? ""}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          90,
                                                  fontWeight: FontWeight.w400),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          /// subscription info

                          vendorProvider
                                      .selectedVendor!.userSubscriptionStatus ==
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
                                              vendorProvider.selectedVendor!
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
                                                    vendorProvider
                                                                .selectedVendor!
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
                                              vendorProvider.selectedVendor!
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
                                              vendorProvider.selectedVendor!
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

                          /// vendors details
                          vendorProvider
                              .selectedVendor!.userSubscriptionStatus ==
                              'active'
                              ?
                          Container(
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
                                                '${vendorProvider.selectedVendor?.firstName}',
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
                                                vendorProvider
                                                    .selectedVendor
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
                                                vendorProvider
                                                    .selectedVendor
                                                    ?.referredBy ??
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
                                                '${vendorProvider.selectedVendor?.lastName}',
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
                                                vendorProvider
                                                    .selectedVendor
                                                    ?.phone ??
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
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 120),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Vendor is subscribed to ${vendorProvider.selectedVendor!.subscription?.planDetails?.name ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "₹${vendorProvider.selectedVendor!.subscription?.planDetails?.rate ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 48,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                              "This pack is valid for ${vendorProvider.selectedVendor!.subscription?.planDetails?.validityInDays ?? ""} days only.",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                              "Last recharge done on ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.lastRechargeDate ?? DateTime.now())}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                              "Next recharge date ${DateFormat.yMMMEd().format(vendorProvider.selectedVendor!.subscription?.nextRechargeDate ?? DateTime.now())}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ): const SizedBox(),
                          

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
