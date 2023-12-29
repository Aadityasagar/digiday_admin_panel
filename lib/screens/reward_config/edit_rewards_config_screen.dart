import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/reward_config_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class EditRewardsConfigScreen extends StatelessWidget {
  EditRewardsConfigScreen({super.key});
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
              largeScreen: getDesktopEditRewardConfigScreen(),
              smallScreen: getMobileEditRewardConfigScreen(context),
              mediumScreen: getTabEditRewardConfigScreen(context),
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

Widget getMobileEditRewardConfigScreen(BuildContext context) {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {
    TextFormField buildFirstShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.first,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "First Share",
          hintText: "Enter First Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildSecondShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.second,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Second Share",
          hintText: "Enter Second Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildThirdShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.third,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Third Share",
          hintText: "Enter Third Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFourthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fourth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fourth Share",
          hintText: "Enter Fourth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFifthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fifth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fifth Share",
          hintText: "Enter Fifth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const Text(
              "Edit Reward Configuration",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),

            Center(
              child: Text(rewardConfigProvider.selectedRewardConfig?.id??"",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                  key: rewardConfigProvider.editRewardConfigFormKey,
                  child: Column(children: [
                    const SizedBox(height: 15),
                    buildFirstShareFormField(),
                    const SizedBox(height: 15),
                    buildSecondShareFormField(),
                    const SizedBox(height: 15),
                    buildThirdShareFormField(),
                    const SizedBox(height: 15),
                    buildFourthShareFormField(),
                    const SizedBox(height: 15),
                    buildFifthShareFormField(),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 150,
                      child: DefaultButton(
                        text: "Save",
                        press: () async{
                          try {
                            bool result =  await rewardConfigProvider.validateAndEdit();
                            if (result){
                              Navigator.of(context).pushReplacementNamed(Routes.rewardConfigScreen);}
                            else{
                              print("something went wrong");
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],)),
            )


          ],
        ),
      ),
    );
  });
}

Widget getTabEditRewardConfigScreen(BuildContext context) {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {

    TextFormField buildFirstShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.first,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "First Share",
          hintText: "Enter First Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildSecondShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.second,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Second Share",
          hintText: "Enter Second Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildThirdShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.third,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Third Share",
          hintText: "Enter Third Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFourthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fourth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fourth Share",
          hintText: "Enter Fourth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFifthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fifth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fifth Share",
          hintText: "Enter Fifth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            const Text(
              "Edit Reward Configuration",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(rewardConfigProvider.selectedRewardConfig?.id??"",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kPrimaryColor),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Form(
                  key: rewardConfigProvider.editRewardConfigFormKey,
                  child: Column(children: [
                    const SizedBox(height: 15),
                    buildFirstShareFormField(),
                    const SizedBox(height: 15),
                    buildSecondShareFormField(),
                    const SizedBox(height: 15),
                    buildThirdShareFormField(),
                    const SizedBox(height: 15),
                    buildFourthShareFormField(),
                    const SizedBox(height: 15),
                    buildFifthShareFormField(),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 150,
                      child: DefaultButton(
                        text: "Save",
                        press: () async{
                          try {
                            bool result =  await rewardConfigProvider.validateAndEdit();
                            if (result){
                              Navigator.of(context).pushReplacementNamed(Routes.rewardConfigScreen);}
                            else{
                              print("something went wrong");
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],)),
            )
          ],
        ),
      ),
    );
  });
}

Widget getDesktopEditRewardConfigScreen() {
  return Consumer<RewardConfigProvider>(builder: (context, rewardConfigProvider, child) {

    TextFormField buildFirstShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.first,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "First Share",
          hintText: "Enter First Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildSecondShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.second,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Second Share",
          hintText: "Enter Second Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildThirdShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.third,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Third Share",
          hintText: "Enter Third Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFourthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fourth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fourth Share",
          hintText: "Enter Fourth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }
    TextFormField buildFifthShareFormField() {
      return TextFormField(
        controller: rewardConfigProvider.fifth,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fifth Share",
          hintText: "Enter Fifth Share",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.monetization_on_sharp),
        ),
      );
    }

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
                        "Edit Reward Configuration",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 23,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Text(rewardConfigProvider.selectedRewardConfig?.id??"",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kPrimaryColor),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Form(
                            key: rewardConfigProvider.editRewardConfigFormKey,
                            child: Column(children: [
                              const SizedBox(height: 15),
                              buildFirstShareFormField(),
                              const SizedBox(height: 15),
                              buildSecondShareFormField(),
                              const SizedBox(height: 15),
                              buildThirdShareFormField(),
                              const SizedBox(height: 15),
                              buildFourthShareFormField(),
                              const SizedBox(height: 15),
                              buildFifthShareFormField(),
                              const SizedBox(height: 35),
                              SizedBox(
                                width: 150,
                                child: DefaultButton(
                                  text: "Save",
                                  press: () async{
                                    try {
                                      bool result =  await rewardConfigProvider.validateAndEdit();
                                      if (result){
                                        Navigator.of(context).pushReplacementNamed(Routes.rewardConfigScreen);}
                                      else{
                                        print("something went wrong");
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ),
                              ),
                            ],)),
                      )

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
