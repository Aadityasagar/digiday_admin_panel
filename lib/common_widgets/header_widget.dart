import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/features/account/controller/account_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatefulWidget {
  final double opacity;
  HeaderWidget({Key? key, required this.opacity}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  final AccountController _accountController=Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return
        ResponsiveWidget(
          largeScreen: getDesktopAppbar(),
          smallScreen: getMobileAppbar(),
          mediumScreen: getTabAppbar(),
        );
  }


  Widget getMobileAppbar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("images/logo-rec.png", height: 60,),


          Row(children: [
            Row(children: [
              Icon(CupertinoIcons.search, color: kPrimaryColor, size: 25,),
              SizedBox(width: 5,),
              Text("Search"),
            ],),
            SizedBox(width: 40,),
            Icon(CupertinoIcons.bell_fill, color: kPrimaryColor, size: 25,),
            SizedBox(width: 15,),

            _accountController.getCurrentUser?.photo==null ? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: const CircleAvatar(
                backgroundImage:  AssetImage("images/ProfileImage.png"),
              ),
            ):
            _accountController.profilePicUrl.value!=""? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                backgroundImage:  NetworkImage(_accountController.profilePicUrl.value),
              ),
            ):const SizedBox(),
          ],)



        ],
      ),
    );
  }
  Widget getTabAppbar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/logo-rec.png", height: 60,),
              SizedBox(width: 10,),
              Text("Welcome, Admin", style: TextStyle(
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800
              ),)
            ],
          ),


          Row(children: [
            Row(children: [
              Icon(CupertinoIcons.search, color: kPrimaryColor, size: 25,),
              SizedBox(width: 5,),
              Text("Search"),
            ],),
            SizedBox(width: 40,),
            Icon(CupertinoIcons.bell_fill, color: kPrimaryColor, size: 25,),
            SizedBox(width: 15,),

            _accountController.getCurrentUser?.photo==null ? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: const CircleAvatar(
                backgroundImage:  AssetImage("images/ProfileImage.png"),
              ),
            ):
            _accountController.profilePicUrl.value!=""? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                backgroundImage:  NetworkImage(_accountController.profilePicUrl.value),
              ),
            ):const SizedBox(),
          ],)



        ],
      ),
    );
  }
  Widget getDesktopAppbar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/logo-rec.png", height: 60,),
              SizedBox(width: 50,),
              Text("Welcome, Admin", style: TextStyle(
                fontSize: 35, color: Colors.black, fontWeight: FontWeight.w800
              ),)
            ],
          ),

          Row(children: [
            Row(children: [
              Icon(CupertinoIcons.search, color: kPrimaryColor, size: 25,),
              SizedBox(width: 5,),
              Text("Search"),
            ],),
            SizedBox(width: 60,),
            Icon(CupertinoIcons.bell_fill, color: kPrimaryColor, size: 25,),
            SizedBox(width: 15,),

            _accountController.getCurrentUser?.photo==null ? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: const CircleAvatar(
                backgroundImage:  AssetImage("images/ProfileImage.png"),
              ),
            ):
            _accountController.profilePicUrl.value!=""? InkWell(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: CircleAvatar(
                backgroundImage:  NetworkImage(_accountController.profilePicUrl.value),
              ),
            ):const SizedBox(),
          ],)

        ],
      ),
    );
  }

}




