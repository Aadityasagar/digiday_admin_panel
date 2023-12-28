
import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/payouts_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayoutScreen extends StatelessWidget {
  PayoutScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Consumer<PayoutProvider>(builder: (context, payoutProvider, child) {
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
              largeScreen: getDesktopCmScreen(),
              smallScreen: getMobileCmScreen(context),
              mediumScreen: getTabCmScreen(context),
            ),
          ),
          Offstage(
              offstage: !payoutProvider.isLoading, child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileCmScreen(BuildContext context) {
  return Consumer<PayoutProvider>(builder: (context, payoutProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            const Text(
              "Payout Requests",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            payoutProvider.payoutsList.isNotEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(),
                },
                children: [
                  const TableRow(
                      decoration: BoxDecoration(color: kPrimaryColor),
                      children: [
                        /// name

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

                        /// phone

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// amount

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10),
                            child: Text(
                              "Amount",
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
                              "Approve",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                  ...payoutProvider.payoutsList.asMap().entries.map(
                        (payouts) {
                      return TableRow(
                          decoration:
                          const BoxDecoration(color: Colors.white),
                          children: [
                            /// Name

                            Center(
                              child: Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${payouts.value.firstName}\n${payouts.value.lastName}",
                                ),
                              ),
                            ),

                            /// email

                            Center(
                              child: Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    vertical: 20),
                                child: Text("${payouts.value.email}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),

                            /// phone

                            Center(
                              child: Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    vertical: 20),
                                child: Text(
                                  '${payouts.value.phone}',
                                ),
                              ),
                            ),

                            /// amount

                            Center(
                              child: Padding(
                                padding: const EdgeInsets
                                    .symmetric(
                                    vertical: 20),
                                child: Text(
                                  "${payouts.value.amount}",
                                ),
                              ),
                            ),

                            /// action

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: MaterialButton(
                                  color : Colors.green,
                                  onPressed: (){},
                                  child: const Text("Pay",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),),
                                ),
                              ),
                            )
                          ]);
                    },
                  )
                ],
              ),
            )
                : const Center(
              child: Text('No Payout Requests'),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getTabCmScreen(BuildContext context) {
  return Consumer<PayoutProvider>(builder: (context, payoutProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            const Text(
              "Payout Requests",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: payoutProvider.payoutsList.isNotEmpty
                  ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    const TableRow(
                        decoration: BoxDecoration(color: kPrimaryColor),
                        children: [
                          /// name

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

                          /// phone

                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10),
                              child: Text(
                                "Phone",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),

                          /// amount

                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10),
                              child: Text(
                                "Amount",
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
                                "Approve",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                    ...payoutProvider.payoutsList.asMap().entries.map(
                          (payouts) {
                        return TableRow(
                            decoration:
                            const BoxDecoration(color: Colors.white),
                            children: [
                              /// Name

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical: 20),
                                  child: Text(
                                    "${payouts.value.firstName}${payouts.value.lastName}",
                                  ),
                                ),
                              ),

                              /// email

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical: 20),
                                  child: Text("${payouts.value.email}",
                                  ),
                                ),
                              ),

                              /// phone

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical: 20),
                                  child: Text(
                                    '${payouts.value.phone}',
                                  ),
                                ),
                              ),

                              /// amount

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical: 20),
                                  child: Text(
                                    "${payouts.value.amount}",
                                  ),
                                ),
                              ),

                              /// action

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: MaterialButton(
                                    color : Colors.green,
                                    onPressed: (){},
                                    child: const Text("Transfer Now",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),),
                                  ),
                                ),
                              )
                            ]);
                      },
                    )
                  ],
                ),
              )
                  : const Center(
                child: Text('No Payout Requests'),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopCmScreen() {
  return Consumer<PayoutProvider>(builder: (context, payoutProvider, child) {
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
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Payout Requests",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 23,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            payoutProvider.payoutsList.isNotEmpty
                                ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(),
                                  3: FlexColumnWidth(1),
                                  4: FlexColumnWidth(),
                                },
                                children: [
                                  const TableRow(
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor),
                                      children: [
                                        /// name

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

                                        /// phone

                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "Phone",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),

                                        /// amount

                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "Amount",
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
                                              "Approve",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  ...payoutProvider.payoutsList
                                      .asMap()
                                      .entries
                                      .map(
                                        (payouts) {
                                      return TableRow(
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          children: [
                                            /// Name

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  "${payouts.value.firstName}${payouts.value.lastName}",
                                                ),
                                              ),
                                            ),

                                            /// email

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 20),
                                                child: Text("${payouts.value.email}",
                                                ),
                                              ),
                                            ),

                                            /// phone

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  '${payouts.value.phone}',
                                                ),
                                              ),
                                            ),

                                            /// amount

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  "${payouts.value.amount}",
                                                ),
                                              ),
                                            ),

                                            /// action

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: MaterialButton(
                                                  color : Colors.green,
                                                  onPressed: (){},
                                                  child: const Text("Transfer Now",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                            ),
                                              ),
                                            )

                                          ]);
                                    },
                                  )
                                ],
                              ),
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
