import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CmScreen extends StatelessWidget {
  CmScreen({super.key});

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
            extendBody: true,
            extendBodyBehindAppBar: true,
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
              offstage: !cmProvider.isLoading, child: const AppThemedLoader())
        ],
      );
    });
  }
}

Widget getMobileCmScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  DefaultTabController(
          length: cmProvider.pageTabs.length,
          initialIndex: 0,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/7,),
              const Text(
                "Circle Managers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  tabs: cmProvider.pageTabs,
                  labelColor: Colors.black),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                    children: [
                      ///Active

                      Column(
                        children: [
                          cmProvider.activeCmTeamMates.isNotEmpty
                              ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(),
                                3: FlexColumnWidth(1),
                              },
                              children: [
                                const TableRow(
                                    decoration: BoxDecoration(color: kPrimaryColor),
                                    children: [

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

                                      /// Phone Number

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Phone Number",
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
                                ...cmProvider.activeCmTeamMates.asMap().entries.map(
                                      (cmTeamMates) {
                                    return TableRow(
                                        decoration:
                                        const BoxDecoration(color: Colors.white),
                                        children: [

                                          /// image

                                          Center(
                                            child: cmTeamMates.value.photo == null
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
                                                  backgroundImage: NetworkImage(cmTeamMates.value.photo ?? ""),
                                                  radius: 30,
                                                )),
                                          ),

                                          /// name

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                '${cmTeamMates.value.firstName??""} ${cmTeamMates.value.lastName??""}',
                                              ),
                                            ),
                                          ),

                                          /// Phone Number

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                cmTeamMates.value.phone??"",
                                              ),
                                            ),
                                          ),

                                          /// action

                                          Center(
                                            child: IconButton(onPressed: (){
                                              cmProvider.selectedCm=cmTeamMates.value;
                                              Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                            },
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
                        ],
                      ),

                      /// Inactive

                      Column(
                        children: [
                          cmProvider.inactiveCmTeamMates.isNotEmpty
                              ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(),
                                3: FlexColumnWidth(1),
                              },
                              children: [
                                const TableRow(
                                    decoration: BoxDecoration(color: kPrimaryColor),
                                    children: [

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

                                      /// Phone Number

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Phone Number",
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
                                ...cmProvider.inactiveCmTeamMates.asMap().entries.map(
                                      (cmTeamMates) {
                                    return TableRow(
                                        decoration:
                                        const BoxDecoration(color: Colors.white),
                                        children: [

                                          /// image

                                          Center(
                                            child: cmTeamMates.value.photo == null
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
                                                  backgroundImage: NetworkImage(cmTeamMates.value.photo ?? ""),
                                                  radius: 30,
                                                )),
                                          ),

                                          /// name

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                '${cmTeamMates.value.firstName??""} ${cmTeamMates.value.lastName??""}',
                                              ),
                                            ),
                                          ),

                                          /// email

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                cmTeamMates.value.phone??"",
                                              ),
                                            ),
                                          ),

                                          /// action

                                          Center(
                                            child: IconButton(onPressed: (){
                                              cmProvider.selectedCm=cmTeamMates.value;
                                              Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                            },
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
                        ],
                      ),
                    ]),
              )
            ],
          ),
        )

      ),
    );
  });
}

Widget getTabCmScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: cmProvider.pageTabs.length,
          initialIndex: 0,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/7,),
              const Text(
                "Circle Managers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  tabs: cmProvider.pageTabs,
                  labelColor: Colors.black),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                    children: [
                      ///Active

                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: cmProvider.activeCmTeamMates.isNotEmpty
                                ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(),
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

                                        /// Phone Number

                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Text(
                                              "Phone Number",
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
                                  ...cmProvider.activeCmTeamMates.asMap().entries.map(
                                        (cmTeamMates) {
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
                                                  "${cmTeamMates.key + 1}",
                                                ),
                                              ),
                                            ),

                                            /// image

                                            Center(
                                              child: cmTeamMates.value.photo == null
                                                  ? const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                                                  radius: 35,
                                                ),
                                              )
                                                  : Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(cmTeamMates.value.photo ?? ""),
                                                    radius: 35,
                                                  )),
                                            ),

                                            /// name

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  '${cmTeamMates.value.firstName??""} ${cmTeamMates.value.lastName??""}',
                                                ),
                                              ),
                                            ),

                                            /// Phone Number

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  cmTeamMates.value.phone??"",
                                                ),
                                              ),
                                            ),

                                            /// action

                                            Center(
                                              child: IconButton(onPressed: (){
                                                cmProvider.selectedCm=cmTeamMates.value;
                                                Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                              },
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
                          ),
                        ],
                      ),

                      /// Inactive

                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: cmProvider.inactiveCmTeamMates.isNotEmpty
                                ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(),
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

                                        /// Phone Number

                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Text(
                                              "Phone Number",
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
                                  ...cmProvider.inactiveCmTeamMates.asMap().entries.map(
                                        (cmTeamMates) {
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
                                                  "${cmTeamMates.key + 1}",
                                                ),
                                              ),
                                            ),

                                            /// image

                                            Center(
                                              child: cmTeamMates.value.photo == null
                                                  ? const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage("assets/images/ProfileImage.png"),
                                                  radius: 35,
                                                ),
                                              )
                                                  : Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(cmTeamMates.value.photo ?? ""),
                                                    radius: 35,
                                                  )),
                                            ),

                                            /// name

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  '${cmTeamMates.value.firstName??""} ${cmTeamMates.value.lastName??""}',
                                                ),
                                              ),
                                            ),

                                            /// Phone Number

                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  cmTeamMates.value.phone??"",
                                                ),
                                              ),
                                            ),

                                            /// action

                                            Center(
                                              child: IconButton(onPressed: (){
                                                cmProvider.selectedCm=cmTeamMates.value;
                                                Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                              },
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
                          ),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        )

      ),
    );
  });
}

Widget getDesktopCmScreen() {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return SingleChildScrollView(
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
                        "Circle Managers",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 23,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      DefaultTabController(
                        length: cmProvider.pageTabs.length,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                                tabs: cmProvider.pageTabs,
                                labelColor: Colors.black),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/1.2,
                              child: TabBarView(
                                  children: [
                                    /// active
                                    Column(
                                      children: [
                                        cmProvider.activeCmTeamMates.isNotEmpty
                                            ? SizedBox(
                                          height: MediaQuery.of(context).size.height/1.2,
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(1),
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

                                                    /// Phone

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
                                              ...cmProvider.activeCmTeamMates
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (cmTeamMates) {
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
                                                              "${cmTeamMates.key + 1}",
                                                            ),
                                                          ),
                                                        ),

                                                        /// image

                                                        Center(
                                                          child: cmTeamMates.value?.photo == null
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
                                                                backgroundImage: NetworkImage(cmTeamMates.value.photo ?? ""),
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
                                                              '${cmTeamMates.value.firstName??""} ${cmTeamMates.value.lastName??""}',
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
                                                              cmTeamMates.value.phone ??"",
                                                            ),
                                                          ),
                                                        ),

                                                        /// action

                                                        Center(
                                                          child: IconButton(onPressed: (){
                                                            cmProvider.selectedCm=cmTeamMates.value;
                                                            Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                                          },
                                                            icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                                        ),
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
                                    ),

                                    /// inactive

                                    Column(
                                      children: [
                                        cmProvider.inactiveCmTeamMates.isNotEmpty
                                            ? SizedBox(
                                          height: MediaQuery.of(context).size.height/1.2,
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(1),
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
                                              ...cmProvider.inactiveCmTeamMates
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (cmTeamMates) {
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
                                                              "${cmTeamMates.key + 1}",
                                                            ),
                                                          ),
                                                        ),

                                                        /// image

                                                        Center(
                                                          child: cmTeamMates.value?.photo == null
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
                                                                backgroundImage: NetworkImage(cmTeamMates.value?.photo ?? ""),
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
                                                              '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
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
                                                              cmTeamMates.value.phone
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),

                                                        /// action

                                                        Center(
                                                          child: IconButton(onPressed: (){
                                                            cmProvider.selectedCm=cmTeamMates.value;
                                                            Navigator.of(context).pushReplacementNamed(Routes.cmDetailsScreen);

                                                          },
                                                            icon: const Icon(Icons.remove_red_eye_rounded, color: kPrimaryColor,),),
                                                        ),
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
                                  ]),
                            )
                          ],
                        ),
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
