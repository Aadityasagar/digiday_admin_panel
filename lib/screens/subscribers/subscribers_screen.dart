import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/subscription_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SubscribersScreen extends StatelessWidget {
  SubscribersScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Consumer<SubscribersProvider>(builder: (context, subscribersProvider, child) {
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
              largeScreen: getDesktopSubscriptionScreen(context),
              smallScreen: getMobileSubscriptionScreen(context),
              mediumScreen: getTabSubscriptionScreen(context),
            ),
          ),
          Offstage(
              offstage: !subscribersProvider.isLoading, child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileSubscriptionScreen(BuildContext context) {
  return Consumer<SubscribersProvider>(builder: (context, subscribersProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Subscribers",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTabController(
              length: subscribersProvider.pageTabs.length,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                      tabs: subscribersProvider.pageTabs,
                      labelColor: Colors.black),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                        children: [
                          subscribersProvider.activeVendors.isNotEmpty
                              ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(),
                                1: FlexColumnWidth(),
                              },
                              children: [
                                const TableRow(
                                    decoration: BoxDecoration(color: kPrimaryColor),
                                    children: [


                                      /// Name

                                      // Center(
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(vertical: 10),
                                      //     child: Text(
                                      //       "Name",
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           color: Colors.white),
                                      //     ),
                                      //   ),
                                      // ),

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
                                ...subscribersProvider.activeVendors.asMap().entries.map(
                                      (activeVendors) {
                                    return TableRow(
                                        decoration:
                                        const BoxDecoration(color: Colors.white),
                                        children: [

                                          /// name

                                          // Center(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.symmetric(
                                          //         vertical: 20),
                                          //     child: Text(
                                          //       '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
                                          //     ),
                                          //   ),
                                          // ),

                                          /// email

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                activeVendors.value.nextRechargeDate.toString(),
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
                            child: Text('No Cm Added'),
                          ),
                          getInActiveSubscribersList(context),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
}

Widget getTabSubscriptionScreen(BuildContext context) {
  return Consumer<SubscribersProvider>(builder: (context, subscribersProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Subscribers",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTabController(
              length: subscribersProvider.pageTabs.length,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                      tabs: subscribersProvider.pageTabs,
                      labelColor: Colors.black),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                        children: [
                          getActiveSubscribersList(context),
                          getInActiveSubscribersList(context),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  });
}

Widget getDesktopSubscriptionScreen(BuildContext context) {
  return Consumer<SubscribersProvider>(builder: (context, subscribersProvider, child) {
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
                      "Subscribers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                        DefaultTabController(
                          length: subscribersProvider.pageTabs.length,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                  tabs: subscribersProvider.pageTabs,
                                  labelColor: Colors.black),
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: TabBarView(
                                    children: [
                                      getActiveSubscribersList(context),
                                      getInActiveSubscribersList(context),
                                    ]),
                              )
                            ],
                          ),
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

Widget getActiveSubscribersList(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
      ],
    ),
  );
}

Widget getInActiveSubscribersList(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(color: Colors.grey, height: 400, width: MediaQuery.of(context).size.width,)
      ],
    ),
  );
}