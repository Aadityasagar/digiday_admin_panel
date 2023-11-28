import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
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

    return Consumer<CmProvider>(
      builder: (context,cmProvider,child) {
        return Stack(
          children: [
            Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: HeaderWidget(opacity: _opacity),
              ),
              drawer: ExploreDrawer(),
              body: ResponsiveWidget(
                largeScreen: getDesktopCmScreen(),
                smallScreen: getMobileCmScreen(context),
                mediumScreen: getTabCmScreen(context),
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

Widget getMobileCmScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "CM Team",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            cmProvider.cmTeamMates.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child:
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(5),
                      },
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(color: kPrimaryColor),
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "NAME",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "EMAIL",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
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
                        ...cmProvider.cmTeamMates.asMap().entries.map(
                          (cmTeamMates) {
                            return TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        cmTeamMates.value.email.toString(),
                                      ),
                                    ),
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.blue),
                            underline: Container(
                            height: 2,
                            color: Colors.blue,
                            ),
                            onChanged: (String? newValue) {
                            },
                            items: <String>['Item 1', 'Item 2', 'Item 3', 'Item 4']
                                .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            );
                            }).toList(),
                            ),

                                    ),
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
      ),
    );
  });
}

Widget getTabCmScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "CM Team",
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
              child: cmProvider.cmTeamMates.isNotEmpty
                  ? Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(5),
                      },
                      border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(color: kPrimaryColor),
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "S. NO.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "NAME",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "EMAIL",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ]),
                        ...cmProvider.cmTeamMates.asMap().entries.map(
                          (cmTeamMates) {
                            return TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        "${cmTeamMates.key + 1}",
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        cmTeamMates.value.email.toString(),
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        )
                      ],
                    )
                  : const Center(
                      child: Text('No Cm Added'),
                    ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getDesktopCmScreen() {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
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
                          "All Circle Managers",
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
                           cmProvider.cmTeamMates.isNotEmpty
                               ? Table(
                             columnWidths: const {
                               0: FlexColumnWidth(1),
                               1: FlexColumnWidth(4),
                               2: FlexColumnWidth(5),
                             },
                             children: [
                               const TableRow(
                                   decoration: BoxDecoration(color: kPrimaryColor),
                                   children: [
                                     Center(
                                       child: Padding(
                                         padding: EdgeInsets.symmetric(
                                             vertical: 10),
                                         child: Text(
                                           "Photo",
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         ),
                                       ),
                                     ),
                                     Center(
                                       child: Padding(
                                         padding: EdgeInsets.symmetric(
                                             vertical: 10),
                                         child: Text(
                                           "NAME",
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         ),
                                       ),
                                     ),
                                     Center(
                                       child: Padding(
                                         padding: EdgeInsets.symmetric(
                                             vertical: 10),
                                         child: Text(
                                           "EMAIL",
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         ),
                                       ),
                                     ),
                                   ]),
                               ...cmProvider.cmTeamMates.asMap().entries.map(
                                     (cmTeamMates) {
                                   return TableRow(
                                       decoration: const BoxDecoration(
                                           color: Colors.white),
                                       children: [
                                         Center(
                                           child: cmTeamMates.value?.photo==null ? const Padding(
                                             padding: EdgeInsets.all(2.0),
                                             child: CircleAvatar(
                                               backgroundImage:  AssetImage("images/ProfileImage.png"),
                                             ),
                                           ):
                                           Padding(
                                             padding: const EdgeInsets.all(2.0),
                                             child: CircleAvatar(
                                               backgroundImage: NetworkImage(cmTeamMates.value?.photo??""),
                                             ),
                                           ),
                                         ),
                                         Center(
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.symmetric(
                                                 vertical: 20),
                                             child: Text(
                                               '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
                                             ),
                                           ),
                                         ),
                                         Center(
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.symmetric(
                                                 vertical: 20),
                                             child: Text(
                                               cmTeamMates.value.email.toString(),
                                             ),
                                           ),
                                         ),
                                       ]);
                                 },
                               )
                             ],
                           )
                               :  const Center(
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


