import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/screens/vendors/controller/vendor_controller.dart';
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
            largeScreen: getDesktopVendorScreen(),
            mediumScreen: getTabVendorScreen(),
            smallScreen: getMobileVendorScreen(),
          )),
    );
  }
}

Widget getMobileVendorScreen() {
  final VendorController _vendorController = Get.put(VendorController());
  return Column(
    children: [
      const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),),
      const SizedBox(height: 10,),
      Expanded(
        child: _vendorController.vendorMates.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _vendorController.vendorMates.length,
                itemBuilder: (BuildContext context, int index) {
                  return VendorCard(
                    firstName:
                        "${_vendorController.vendorMates[index].firstName} ${_vendorController.vendorMates[index].lastName}",
                    phone: _vendorController.vendorMates[index].phone,
                    email: _vendorController.vendorMates[index].email,
                  );
                })
            : const Center(child: Text("No CM Added")),
      ),
    ],
  );
}

Widget getTabVendorScreen() {
  final VendorController _vendorController = Get.put(VendorController());
  return Column(
    children: [
      const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),),
      const SizedBox(height: 10,),
      Expanded(
        child: _vendorController.vendorMates.isNotEmpty
            ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4.0 / 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            itemCount: _vendorController.vendorMates.length,
            itemBuilder: (BuildContext context, int index) {
              return VendorCard(
                firstName:
                "${_vendorController.vendorMates[index].firstName} ${_vendorController.vendorMates[index].lastName}",
                phone: _vendorController.vendorMates[index].phone,
                email: _vendorController.vendorMates[index].email,
              );
            })
            : const Center(child: Text("No CM Added")),
      ),
    ],
  );
}

Widget getDesktopVendorScreen() {
  final VendorController _vendorController = Get.put(VendorController());
  return Column(
    children: [
      const Text("Vendors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),),
      const SizedBox(height: 10,),
      Expanded(
        child: _vendorController.vendorMates.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 4.0 / 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: _vendorController.vendorMates.length,
                itemBuilder: (BuildContext context, int index) {
                  return VendorCard(
                    firstName:
                        "${_vendorController.vendorMates[index].firstName} ${_vendorController.vendorMates[index].lastName}",
                    phone: _vendorController.vendorMates[index].phone,
                    email: _vendorController.vendorMates[index].email,
                  );
                })
            : const Center(child: Text("No CM Added")),
      ),
    ],
  );
}

class VendorCard extends StatelessWidget {
  String? firstName;
  String? phone;
  String? email;

  VendorCard({
    super.key,
    required this.firstName,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue.shade50,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/60:
                        MediaQuery.of(context).size.width/40,
                      ),
                    ),
                    Text(
                      "$firstName",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/80:
                        MediaQuery.of(context).size.width/50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone Number : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/60:
                        MediaQuery.of(context).size.width/40,
                      ),
                    ),
                    Text(
                      phone ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/80:
                        MediaQuery.of(context).size.width/50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/60:
                        MediaQuery.of(context).size.width/40,
                      ),
                    ),
                    Text(
                      email ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveWidget.isLargeScreen(context)? MediaQuery.of(context).size.width/80:
                        MediaQuery.of(context).size.width/50,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // DefaultButton(
                //   text: 'Contact',
                //   press: (){
                //     Get.to(EditBankAccountDetails());
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
