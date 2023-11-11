import 'package:digiday_admin_panel/appstate_controller/appstate_controller.dart';
import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:digiday_admin_panel/features/account/view/components/profile_menu.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/products/controller/products_controller.dart';
import 'package:digiday_admin_panel/features/products/products_screen.dart';
import 'package:digiday_admin_panel/screens/cm/cm_screen.dart';
import 'package:digiday_admin_panel/screens/cm/controller/cm_controller.dart';
import 'package:digiday_admin_panel/screens/vendors/controller/vendor_controller.dart';
import 'package:digiday_admin_panel/screens/vendors/vendor_screen.dart';
import 'package:digiday_admin_panel/utils/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());

  final AccountController _accountController = Get.put(AccountController());

  double _opacity = 0;

  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: HeaderWidget(opacity: _opacity),
      ),
      drawer: ExploreDrawer(),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          largeScreen: getDesktopHomePage(context),
          mediumScreen: getTabHomePage(context),
          smallScreen: getMobileHomePage(context),
        ),
      ),
    );
  }

  Widget getMobileHomePage(BuildContext context) {
    final VendorController vendorController = Get.put(VendorController());
    final CmController cmController =Get.put(CmController());
    final ProductController productController =Get.put(ProductController());
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: vendorController.vendorMates.length.toString(),
          press: () {
            Get.to(() => VendorScreen());
          },
          color: const Color(0xfffbbd05)),
      HomeActions(
          title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: cmController.cmTeamMates.length.toString(),
          press: () {
            Get.to(() => CmScreen());
          },
          color: const Color(0xff4387f5)),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {},
          color: const Color(0xffeb4234)),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: productController.products.length.toString(),
          press: () {
            Get.to(() => ProductScreen());
          },
          color: const Color(0xff34a952))
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: () {
            //Get.to(AddAdminScreen());
          }),
      QuickAction(title: "Admins", icon: Icons.person_2_sharp, press: () {}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: () {
            //Get.to(const PayoutScreen());
          }),
      QuickAction(title: "Referer Someone", icon: Icons.share, press: () {})
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Welcome, Admin",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4.0 / 2.2,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                      ),
                      itemCount: homeActions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeActionsCard(
                          icon: homeActions[index].icon,
                          title: homeActions[index].title,
                          press: homeActions[index].press,
                          count: homeActions[index].count,
                          color: homeActions[index].color,
                        );
                      }),
                ),

                /// quick actions
                const Center(
                  child: Text(
                    'Quick Actions',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: actions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuickActionsCard(
                          icon: actions[index].icon,
                          title: actions[index].title,
                          press: actions[index].press,
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getTabHomePage(BuildContext context) {
    final VendorController vendorController = Get.put(VendorController());
    final CmController cmController =Get.put(CmController());
    final ProductController productController =Get.put(ProductController());
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: vendorController.vendorMates.length.toString(),
          press: () {
            Get.to(() => VendorScreen());
          },
          color: const Color(0xfffbbd05)),
      HomeActions(
          title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: cmController.cmTeamMates.length.toString(),
          press: () {
            Get.to(() => CmScreen());
          },
          color: const Color(0xff4387f5)),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {},
          color: const Color(0xffeb4234)),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: productController.products.length.toString(),
          press: () {
            Get.to(() => ProductScreen());
          },
          color: const Color(0xff34a952))
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: () {
           // Get.to(AddAdminScreen());
          }),
      QuickAction(title: "Admins", icon: Icons.person_2_sharp, press: () {}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: () {
            //Get.to(const PayoutScreen());
          }),
      QuickAction(title: "Referer Someone", icon: Icons.share, press: () {})
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeActions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeActionsCard(
                          icon: homeActions[index].icon,
                          title: homeActions[index].title,
                          press: homeActions[index].press,
                          count: homeActions[index].count,
                          color: homeActions[index].color,
                        );
                      }),
                ),

                /// quick actions
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: actions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuickActionsCard(
                          icon: actions[index].icon,
                          title: actions[index].title,
                          press: actions[index].press,
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getDesktopHomePage(BuildContext context) {
    final VendorController vendorController = Get.put(VendorController());
    final CmController cmController =Get.put(CmController());
    final ProductController productController =Get.put(ProductController());
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: vendorController.vendorMates.length.toString(),
          press: () {
            Get.to(() => VendorScreen());
          },
          color: const Color(0xfffbbd05)),
      HomeActions(
          title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: cmController.cmTeamMates.length.toString(),
          press: () {
            Get.to(() => CmScreen());
          },
          color: const Color(0xff4387f5)),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {},
          color: const Color(0xffeb4234)),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: productController.products.length.toString(),
          press: () {
            Get.to(() => ProductScreen());
          },
          color: const Color(0xff34a952))
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: () {
           // Get.to(AddAdminScreen());
          }),
      QuickAction(title: "Admins", icon: Icons.person_2_sharp, press: () {}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: () {
           // Get.to(const PayoutScreen());
          }),
      QuickAction(title: "Referer Someone", icon: Icons.share, press: () {})
    ];
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              /// blank space

              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileMenu(
                        text: "My Account",
                        icon: CupertinoIcons.person_alt,
                        press: () => Get.toNamed(AppRoutes.editProfileScreen)),
                    ProfileMenu(
                      text: "Notifications",
                      icon: CupertinoIcons.bell_fill,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Settings",
                      icon: Icons.settings,
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: Icons.logout,
                      press: () => CommonFunctions.logoutUser(),
                    ),
                  ],
                ),
              ),

              /// side space

              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeActions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeActionsCard(
                              icon: homeActions[index].icon,
                              title: homeActions[index].title,
                              press: homeActions[index].press,
                              count: homeActions[index].count,
                              color: homeActions[index].color,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// quick actions
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),

                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 1,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                            ),
                            itemCount: actions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return QuickActionsCard(
                                icon: actions[index].icon,
                                title: actions[index].title,
                                press: actions[index].press,
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class HomeActions {
  String title;
  Color color;
  String count;
  IconData icon;
  VoidCallback press;

  HomeActions(
      {required this.title,
      required this.icon,
      required this.press,
      required this.count,
      required this.color});
}

class HomeActionsCard extends StatelessWidget {
  const HomeActionsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.press,
    required this.color,
  }) : super(key: key);

  final String title;
  final String count;
  final IconData icon;
  final GestureTapCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: press,
        child: Container(
          width: ResponsiveWidget.isMediumScreen(context)
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(
                  count!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: ResponsiveWidget.isLargeScreen(context)
                          ? MediaQuery.of(context).size.width / 40
                          : MediaQuery.of(context).size.width / 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ResponsiveWidget.isLargeScreen(context)
                          ? MediaQuery.of(context).size.width / 80
                          : MediaQuery.of(context).size.width / 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuickAction {
  String title;
  IconData icon;
  VoidCallback press;

  QuickAction({required this.title, required this.icon, required this.press});
}

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Icon(
                    icon,
                    color: kPrimaryColor,
                    size: 45,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveWidget.isSmallScreen(context)
                          ? MediaQuery.of(context).size.width / 30
                          : MediaQuery.of(context).size.width / 60),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
