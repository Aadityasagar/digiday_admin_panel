import 'package:digiday_admin_panel/appstate_controller/appstate_controller.dart';
import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:digiday_admin_panel/features/account/view/components/profile_menu.dart';
import 'package:digiday_admin_panel/features/account/view/components/profile_pic.dart';
import 'package:digiday_admin_panel/features/add_admin/add_admin_screen.dart';
import 'package:digiday_admin_panel/features/common/common_functions.dart';
import 'package:digiday_admin_panel/features/payouts/payout_screen.dart';
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
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: "10",
          press: () {}),
      HomeActions(title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: "100",
          press: () {}),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {}),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: "10000+",
          press: () {})
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: (){
            Get.to(AddAdminScreen());
          }),
      QuickAction(
          title: "Admins",
          icon: Icons.person_2_sharp,
          press: (){}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: (){
            Get.to(const PayoutScreen());
          }),
      QuickAction(
          title: "Referer Someone",
          icon: Icons.share,
          press: (){})
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [SizedBox(height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:4.0/2.7,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                    ),
                    itemCount: homeActions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeActionsCard(
                          icon: homeActions[index].icon,
                          title: homeActions[index].title,
                          press: homeActions[index].press,
                        count: homeActions[index].count,);
                    }
                ),
              ),

              /// quick actions
              const  Text('Quick Actions',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              Expanded(child:  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: actions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuickActionsCard(
                      icon: actions[index].icon,
                      title: actions[index].title,
                      press: actions[index].press,

                    );
                  }
              ),),

            ],
          ),
        )],
      ),
    );
  }

  Widget getTabHomePage(BuildContext context) {
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: "10",
          press: () {}),
      HomeActions(title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: "100",
          press: () {}),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {}),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: "10000+",
          press: () {})
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: (){
            Get.to(AddAdminScreen());
          }),
      QuickAction(
          title: "Admins",
          icon: Icons.person_2_sharp,
          press: (){}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: (){
            Get.to(const PayoutScreen());
          }),
      QuickAction(
          title: "Referer Someone",
          icon: Icons.share,
          press: (){})
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [SizedBox(height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/3.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeActions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeActionsCard(
                        icon: homeActions[index].icon,
                        title: homeActions[index].title,
                        press: homeActions[index].press,
                        count: homeActions[index].count,

                      );
                    }
                ),
              ),
              /// quick actions
              const  Text('Quick Actions',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              Expanded(child:  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: actions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuickActionsCard(
                      icon: actions[index].icon,
                      title: actions[index].title,
                      press: actions[index].press,

                    );
                  }
              ),),
            ],
          ),
        )],
      ),
    );
  }

  Widget getDesktopHomePage(BuildContext context) {
    List<HomeActions> homeActions = [
      HomeActions(
          title: "Total Vendors",
          icon: CupertinoIcons.person_alt,
          count: "10",
          press: () {}),
      HomeActions(title: "CM Team",
          icon: CupertinoIcons.person_3_fill,
          count: "100",
          press: () {}),
      HomeActions(
          title: "Total Orders",
          icon: Icons.shopping_cart,
          count: "1000+",
          press: () {}),
      HomeActions(
          title: "Total Products",
          icon: Icons.local_mall,
          count: "10000+",
          press: () {})
    ];
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: (){
            Get.to(AddAdminScreen());
          }),
      QuickAction(
          title: "Admins",
          icon: Icons.person_2_sharp,
          press: (){}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: (){
            Get.to(const PayoutScreen());
          }),
      QuickAction(
          title: "Referer Someone",
          icon: Icons.share,
          press: (){})
    ];
    return Column(
      children: [SizedBox(height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            /// blank space

            SizedBox(width: MediaQuery.of(context).size.width/4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileMenu(
                      text: "My Account",
                      icon: "assets/icons/User Icon.svg",
                      press: ()=>Get.toNamed(AppRoutes.editProfileScreen)
                  ),
                  ProfileMenu(
                    text: "Notifications",
                    icon: "assets/icons/Bell.svg",
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Settings",
                    icon: "assets/icons/Settings.svg",
                    press: () {},
                  ),

                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: ()=> CommonFunctions.logoutUser(),
                  ),
                ],
              ),
            ),

            /// side space

            SizedBox(width: MediaQuery.of(context).size.width/1.4,
              child: Column(
                children: [
                  SizedBox( height:MediaQuery.of(context).size.height/3,
                    child:  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeActions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeActionsCard(
                          icon: homeActions[index].icon,
                          title: homeActions[index].title,
                          press: homeActions[index].press,
                          count: homeActions[index].count,

                        );
                      }
                  ),),
                  const SizedBox(height: 10,),
                  /// quick actions
                  const  Text('Quick Actions',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  Expanded(child:  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: actions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuickActionsCard(
                          icon: actions[index].icon,
                          title: actions[index].title,
                          press: actions[index].press,

                        );
                      }
                  ),),
                ],
              ),
            ),
          ],
        ),
      )],
    );
  }
}

class HomeActions {
  String title;
  String count;
  IconData icon;
  VoidCallback press;

  HomeActions({required this.title, required this.icon, required this.press, required this.count});
}

class HomeActionsCard extends StatelessWidget {
  const HomeActionsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.press,
  }) : super(key: key);

  final String title;
  final String count;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: ResponsiveWidget.isMediumScreen(context)? MediaQuery.of(context).size.width/3:
        MediaQuery.of(context).size.width/6,
        decoration: BoxDecoration(color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),),

        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(width: 10),
                Icon(icon, color: kPrimaryColor,
                  size: ResponsiveWidget.isSmallScreen(context)? MediaQuery.of(context).size.height/10:
                  MediaQuery.of(context).size.height/6),
                const SizedBox(height: 10,),
                Text(title!, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18
                  ),),

                const SizedBox(height: 5,),
                Text(count!, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuickAction{
  String title;
  IconData icon;
  VoidCallback press;

  QuickAction({
    required this.title,
    required this.icon,
    required this.press
  });
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
      child: Container(decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(15)),

        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 45,),
                ),
                const SizedBox(width: 20),
                Text(title!, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),),

                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}