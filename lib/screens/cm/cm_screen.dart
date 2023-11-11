import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/screens/cm/controller/cm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: HeaderWidget(opacity: _opacity),
        ),
        drawer: ExploreDrawer(),
        body: ResponsiveWidget(
          largeScreen: getDesktopCmScreen(context),
          smallScreen: getMobileCmScreen(context),
          mediumScreen: getTabCmScreen(context),
        ),
      ),
    );
  }
}

Widget getMobileCmScreen(BuildContext context) {
  final CmController _cmController = Get.put(CmController());
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "CM Team",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          _cmController.cmTeamMates.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Table(
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
                      ..._cmController.cmTeamMates.asMap().entries.map(
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
                  ),
                )
              : const Center(
                  child: Text('No Cm Added'),
                ),
        ],
      ),
    ),
  );
}

Widget getTabCmScreen(BuildContext context) {
  final CmController _cmController = Get.put(CmController());
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "CM Team",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _cmController.cmTeamMates.isNotEmpty
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
                      ..._cmController.cmTeamMates.asMap().entries.map(
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
}

Widget getDesktopCmScreen(BuildContext context) {
  final CmController _cmController = Get.put(CmController());
  return SingleChildScrollView(
    child: Column(
      children: [
        const Text(
          "CM Team",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(width:MediaQuery.of(context).size.width/4,),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.4,
              height: MediaQuery.of(context).size.height,
              child: _cmController.cmTeamMates.isNotEmpty
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
                        ..._cmController.cmTeamMates.asMap().entries.map(
                          (cmTeamMates) {
                            return TableRow(
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                children: [
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                        "${cmTeamMates.key + 1}",
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                        '${cmTeamMates.value.firstName} ${cmTeamMates.value.lastName}',
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 20),
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
      ],
    ),
  );
}
