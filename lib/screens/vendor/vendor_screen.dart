import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/vendors_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorScreen extends StatelessWidget {
  VendorScreen({super.key});

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
            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: HeaderWidget(opacity: _opacity),
            ),
            drawer: ExploreDrawer(),
            body: ResponsiveWidget(
              largeScreen: getDesktopVendorScreen(),
              smallScreen: getMobileVendorScreen(context),
              mediumScreen: getTabVendorScreen(context),
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

Widget getMobileVendorScreen(BuildContext context) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Vendors",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            vendorProvider.vendorMates.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(3),
                        4: FlexColumnWidth(),
                      },
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(color: kPrimaryColor),
                            children: [
                              /// s.no

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "S.No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// image

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// Name

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// email

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// action

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Action",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ]),
                        ...vendorProvider.vendorMates.asMap().entries.map(
                          (vendorMates) {
                            return TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  /// s.no

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        "${vendorMates.key + 1}",
                                      ),
                                    ),
                                  ),

                                  /// image

                                  Center(
                                    child: vendorMates.value?.photo == null
                                        ? const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("images/ProfileImage.png"),
                                        radius: 35,
                                      ),
                                    )
                                        : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(vendorMates.value?.photo ?? ""),
                                          radius: 35,
                                        )),
                                  ),

                                  /// name

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  /// email

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        vendorMates.value.email.toString(),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  /// action

                                  Center(
                                    child: IconButton(onPressed: (){},
                                      icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                  ),
                                ]);
                          },
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: Text('No Vendor Added'),
                  ),
          ],
        ),
      ),
    );
  });
}

Widget getTabVendorScreen(BuildContext context) {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Vendors",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: vendorProvider.vendorMates.isNotEmpty
                  ? Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(3),
                        4: FlexColumnWidth(),
                      },
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(color: kPrimaryColor),
                            children: [
                              /// s.no

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "S.No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// image

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// Name

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// email

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              /// action

                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Action",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ]),
                        ...vendorProvider.vendorMates.asMap().entries.map(
                          (vendorMates) {
                            return TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  /// s.no

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        "${vendorMates.key + 1}",
                                      ),
                                    ),
                                  ),

                                  /// image

                                  Center(
                                    child: vendorMates.value?.photo == null
                                        ? const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("images/ProfileImage.png"),
                                        radius: 35,
                                      ),
                                    )
                                        : Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(vendorMates.value?.photo ?? ""),
                                          radius: 35,
                                        )),
                                  ),

                                  /// name

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  /// email

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        vendorMates.value.email.toString(),
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  /// action

                                  Center(
                                    child: IconButton(onPressed: (){},
                                      icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                  ),
                                ]);
                          },
                        )
                      ],
                    )
                  : const Center(
                      child: Text('No Vendor Added'),
                    ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopVendorScreen() {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
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
                        const Text(
                          "All Vendors",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 23,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            vendorProvider.vendorMates.isNotEmpty
                                ? Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(),
                                      2: FlexColumnWidth(),
                                      3: FlexColumnWidth(3),
                                      4: FlexColumnWidth(),
                                    },
                                    children: [
                                      const TableRow(
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor),
                                          children: [
                                            /// s.no

                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "S.No",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                            /// image

                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Image",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                            /// Name

                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                            /// email

                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),

                                            /// action

                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Text(
                                                  "Action",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      ...vendorProvider.vendorMates
                                          .asMap()
                                          .entries
                                          .map(
                                        (vendorMates) {
                                          return TableRow(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              children: [
                                                /// s.no

                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                      "${vendorMates.key + 1}",
                                                    ),
                                                  ),
                                                ),

                                                /// image

                                                Center(
                                                  child: vendorMates.value?.photo == null
                                                      ? const Padding(
                                                    padding: EdgeInsets.all(2.0),
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage("images/ProfileImage.png"),
                                                      radius: 30,
                                                    ),
                                                  )
                                                      : Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: CircleAvatar(
                                                        backgroundImage: NetworkImage(vendorMates.value?.photo ?? ""),
                                                        radius: 30,
                                                      )),
                                                ),

                                                /// name

                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                      '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),

                                                /// email

                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20),
                                                    child: Text(
                                                      vendorMates.value.email
                                                          .toString(),
                                                      maxLines: 1,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),

                                                /// action

                                                Center(
                                                  child: IconButton(onPressed: (){},
                                                    icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                                ),
                                              ]);
                                        },
                                      )
                                    ],
                                  )
                                : const Center(
                                    child: NoDataView(),
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
