import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/vendors_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:digiday_admin_panel/screens/vendor/vendor_details_screen.dart';
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
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor:  ColourScheme.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: HeaderWidget(opacity: _opacity),
            ),
            drawer: const ExploreDrawer(),
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
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                child: Expanded(
                    child: getTabView()
                )
            )
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
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                child: Expanded(
                    child: getTabView()
                )
            )
          ],
        ),
      ),
    );
  });
}

Widget getDesktopVendorScreen() {
  return Consumer<VendorProvider>(builder: (context, vendorProvider, child) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/7,),
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
                    child: getTabView()
                )
              ],
            ),
          ),
        ],
      ),
    );
  });
}


Widget getTabView(){
  return Consumer<VendorProvider>(
      builder: (context, vendorProvider, child) {
        return DefaultTabController(
          length: vendorProvider.pageTabs.length,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                  tabs: vendorProvider.pageTabs,
                  labelColor: Colors.black),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                    children: [
                      activeVendors(),
                      inactiveVendors(),
                    ]),
              )
            ],
          ),
        );
      }
  );
}

Widget activeVendors(){
  return Consumer<VendorProvider>(
      builder: (context, vendorProvider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  vendorProvider.activeVendorMates.isNotEmpty
                      ? Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(),
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

                            /// Phone Number

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  "Phone Number",
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
                      ...vendorProvider.activeVendorMates
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
                                  child: vendorMates.value.photo == null
                                      ? const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                                      radius: 30,
                                    ),
                                  )
                                      : Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(vendorMates.value.photo ?? ""),
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
                                      '${vendorMates.value.firstName??""} ${vendorMates.value.lastName??""}',
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// Phone Number

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        vertical: 20),
                                    child: Text(
                                      vendorMates.value.phone??"",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: ()async{
                                    await vendorProvider.fetchProductsByVendorId(vendorMates.value.userId??"");
                                    await vendorProvider.fetchOrdersByVendorId(vendorMates.value.userId??"");
                                    await vendorProvider.fetchWalletBalanceByVendorId(vendorMates.value.userId??"");

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VendorDetailsScreen(selectedVendor: vendorMates.value)));

                                  },
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
              ),
            ],
          ),
        );
      }
  );
}

Widget inactiveVendors(){
  return Consumer<VendorProvider>(
      builder: (context, vendorProvider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  vendorProvider.inactiveVendorMates.isNotEmpty
                      ? Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(),
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

                            /// Phone Number

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Text(
                                  "Phone Number",
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
                      ...vendorProvider.inactiveVendorMates
                          .asMap()
                          .entries
                          .map(
                            (inActiveVendorMates) {
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
                                      "${inActiveVendorMates.key + 1}",
                                    ),
                                  ),
                                ),

                                /// image

                                Center(
                                  child: inActiveVendorMates.value.photo == null
                                      ? const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                                      radius: 30,
                                    ),
                                  )
                                      : Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(inActiveVendorMates.value.photo ?? ""),
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
                                      '${inActiveVendorMates.value.firstName??""} ${inActiveVendorMates.value.lastName??""}',
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// Phone Number

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        vertical: 20),
                                    child: Text(
                                      inActiveVendorMates.value.phone??"",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: (){
                                    vendorProvider.fetchProductsByVendorId(inActiveVendorMates.value.userId??"");
                                    vendorProvider.fetchOrdersByVendorId(inActiveVendorMates.value.userId??"");
                                    vendorProvider.fetchWalletBalanceByVendorId(inActiveVendorMates.value.userId??"");

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VendorDetailsScreen(selectedVendor: inActiveVendorMates.value)));

                                  },
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
              ),
            ],
          ),
        );
      }
  );
}
