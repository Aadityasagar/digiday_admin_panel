import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/screens/vendors/controller/vendor_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Obx(
      () => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 1000),
            child: HeaderWidget(opacity: _opacity),
          ),
          drawer: ExploreDrawer(),
          body: ResponsiveWidget(
            largeScreen: getDesktopVendorScreen(context),
            mediumScreen: getTabVendorScreen(context),
            smallScreen: getMobileVendorScreen(context),
          )),
    );
  }
}

Widget getMobileVendorScreen(BuildContext context) {

  final VendorController _vendorController = Get.put(VendorController());
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),),
          const SizedBox(height: 10,),
          SizedBox(height: MediaQuery.of(context).size.height,
            child: _vendorController.vendorMates.isNotEmpty ? Table(
              columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(5),
            },
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [

                const TableRow(
                    decoration: BoxDecoration(
                        color: kPrimaryColor
                    ),
                    children: [

                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "S. NO.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "NAME",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "EMAIL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),

                ..._vendorController.vendorMates.asMap().entries.map(
                      (vendorMates) {
                    return TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "${vendorMates.key + 1}",
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                vendorMates.value.email.toString(),
                              ),
                            ),
                          ),
                        ]);
                  },
                )

              ],
            ) :

            Center(child: Text('No Vendor Added'),),

          ),




        ]

      ),
    ),
  );
}

Widget getTabVendorScreen(BuildContext context) {
  final VendorController _vendorController = Get.put(VendorController());
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),),
          const SizedBox(height: 10,),
          SizedBox(height: MediaQuery.of(context).size.height,
            child: _vendorController.vendorMates.isNotEmpty ? Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(5),
              },
              border: TableBorder.all(width: 1.0, color: Colors.black),
              children: [

                const TableRow(
                    decoration: BoxDecoration(
                        color: kPrimaryColor
                    ),
                    children: [

                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "S. NO.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "NAME",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "EMAIL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ]),

                ..._vendorController.vendorMates.asMap().entries.map(
                      (vendorMates) {
                    return TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "${vendorMates.key + 1}",
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                vendorMates.value.email.toString(),
                              ),
                            ),
                          ),
                        ]);
                  },
                )

              ],
            ) :

            Center(child: Text('No Vendor Added'),),
          ),
        ],
      ),
    ),
  );
}

Widget getDesktopVendorScreen(BuildContext context) {
  final VendorController _vendorController = Get.put(VendorController());
  return SingleChildScrollView(
    child: Column(
      children: [
        const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),),
        const SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width:MediaQuery.of(context).size.width/4,),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.4,
              height: MediaQuery.of(context).size.height,
              child: _vendorController.vendorMates.isNotEmpty ? Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(5),
                },
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [

                  const TableRow(
                    decoration: BoxDecoration(
                      color: kPrimaryColor
                    ),
                      children: [

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "S. NO.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "NAME",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "EMAIL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),

                  ..._vendorController.vendorMates.asMap().entries.map(
                        (vendorMates) {
                      return TableRow(
                          decoration: const BoxDecoration(color: Colors.white),
                          children: [

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "${vendorMates.key + 1}",
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  '${vendorMates.value.firstName} ${vendorMates.value.lastName}',
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  vendorMates.value.email.toString(),
                                ),
                              ),
                            ),
                          ]);
                    },
                  )

                ],
              ) :

                  Center(child: Text('No Vendor Added'),),

            ),
          ],
        ),
      ],
    ),
  );
}


