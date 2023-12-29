import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/reward_config_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RewardConfigScreen extends StatelessWidget {
  RewardConfigScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {
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
              largeScreen: getDesktopRewardConfigScreen(),
              smallScreen: getMobileRewardConfigScreen(context),
              mediumScreen: getTabRewardConfigScreen(context),
            ),
          ),
          Offstage(
              offstage: !rewardConfigProvider.isLoading,
              child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileRewardConfigScreen(BuildContext context) {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const Text(
              "Reward Configuration",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),

            Column(
              children: [
                rewardConfigProvider.rewardConfigList.isNotEmpty
                    ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(),
                      5: FlexColumnWidth(),
                      6: FlexColumnWidth(),
                    },
                    children: [
                      const TableRow(
                          decoration: BoxDecoration(color: kPrimaryColor),
                          children: [

                            /// plan name

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Plan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// First

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "First",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// second

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Second",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// third

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Third",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// Fourth

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Fourth",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// fifth

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Fifth",
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
                      ...rewardConfigProvider.rewardConfigList.asMap().entries.map(
                            (rewardConfig) {
                          return TableRow(
                              decoration:
                              const BoxDecoration(color: Colors.white),
                              children: [

                                /// name

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(rewardConfig.value.id??"",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// first

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.first??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// second

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.second??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// third

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.third??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// fourth

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.fourth??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// fifth

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.fifth??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: (){
                                    rewardConfigProvider.selectRewardConfigToEdit(rewardConfig.value);
                                    Navigator.of(context).pushReplacementNamed(Routes.editRewardConfigScreen);

                                  },
                                    icon: const Icon(Icons.edit, color: kPrimaryColor,),),
                                ),
                              ]);
                        },
                      )
                    ],
                  ),
                )
                    : const Center(
                  child: Text('No Rewards Added'),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  });
}

Widget getTabRewardConfigScreen(BuildContext context) {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const Text(
              "Reward Configuration",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),

            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: rewardConfigProvider.rewardConfigList.isNotEmpty
                      ? Table(
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(),
                      5: FlexColumnWidth(),
                      6: FlexColumnWidth(),
                      7: FlexColumnWidth(),
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

                            /// plan name

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Plan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// First

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "First",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// second

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Second",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// third

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Third",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// Fourth

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Fourth",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                            /// fifth

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Fifth",
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
                      ...rewardConfigProvider.rewardConfigList.asMap().entries.map(
                            (rewardConfig) {
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
                                      "${rewardConfig.key + 1}",
                                    ),
                                  ),
                                ),

                                /// name

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(rewardConfig.value.id??"",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// first

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.first??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// second

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.second??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// third

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.third??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// fourth

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.fourth??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// fifth

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text("${"₹"}${rewardConfig.value.fifth??""}",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                /// action

                                Center(
                                  child: IconButton(onPressed: (){
                                    rewardConfigProvider.selectRewardConfigToEdit(rewardConfig.value);
                                    Navigator.of(context).pushReplacementNamed(Routes.editRewardConfigScreen);

                                  },
                                    icon: const Icon(Icons.edit, color: kPrimaryColor,),),
                                ),
                              ]);
                        },
                      )
                    ],
                  )
                      : const Center(
                    child: Text('No Rewards Added'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopRewardConfigScreen() {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/7,),
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
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        "Reward Configuration",
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
                          rewardConfigProvider.rewardConfigList.isNotEmpty
                              ? Table(
                            columnWidths: const {
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth(),
                              4: FlexColumnWidth(),
                              5: FlexColumnWidth(),
                              6: FlexColumnWidth(),
                              7: FlexColumnWidth(),
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

                                    /// plan name

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Plan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    /// First

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "First",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    /// second

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Second",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    /// third

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Third",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    /// Fourth

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Fourth",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),

                                    /// fifth

                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Fifth",
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
                              ...rewardConfigProvider.rewardConfigList
                                  .asMap()
                                  .entries
                                  .map(
                                    (rewardConfig) {
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
                                              "${rewardConfig.key + 1}",
                                            ),
                                          ),
                                        ),

                                        /// name

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(rewardConfig.value.id??"",
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// first

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text("${"₹"}${rewardConfig.value.first??""}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// second

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text("${"₹"}${rewardConfig.value.second??""}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// third

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text("${"₹"}${rewardConfig.value.third??""}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// fourth

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text("${"₹"}${rewardConfig.value.fourth??""}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// fifth

                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text("${"₹"}${rewardConfig.value.fifth??""}",
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),

                                        /// action

                                        Center(
                                          child: IconButton(onPressed: (){
                                            rewardConfigProvider.selectRewardConfigToEdit(rewardConfig.value);
                                            Navigator.of(context).pushReplacementNamed(Routes.editRewardConfigScreen);

                                          },
                                            icon: const Icon(Icons.edit, color: kPrimaryColor,),),
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
                ),





              ],
            ),
          ),
        ],
      ),
    );
  });
}
