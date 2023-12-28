import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/categories_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/default_button.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<CategoriesProvider>(
        builder: (context,categoriesProvider,child) {
          return Stack(
            children: [
              Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: const ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopAddCategoriesScreen(),
                  smallScreen: getMobileAddCategoriesScreen(context),
                  mediumScreen: getTabAddCategoriesScreen(context),
                ),
              ),
              Offstage(
                  offstage: !categoriesProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}


Widget getMobileAddCategoriesScreen(BuildContext context) {
  return Consumer<CategoriesProvider>(builder: (context, categoriesProvider, child) {

    // categoriesProvider.categoryTitle
    TextFormField buildCategoryNameFormField() {
      return TextFormField(
        controller: categoriesProvider.categoryTitle,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Category Title",
          hintText: "Enter category title",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.title),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text(
              "Add Category",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 23,
                  color: Colors.black),
            ),

            SizedBox(
              child: Form(
                key: categoriesProvider.addCategoryFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    buildCategoryNameFormField(),
                    const SizedBox(height: 15),

                    categoriesProvider.selectedImage!=null ?

                    Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                        color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
                        height: 200, width: 350,
                        child: Padding(
                          padding:  const EdgeInsets.all(8.0),
                          child: Image.memory(categoriesProvider.selectedImage!, fit: BoxFit.contain,),
                        )
                    ):InkWell(
                      onTap: (){
                        categoriesProvider.selectImages();
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                            child: Stack(
                              children: [
                                Image.asset("assets/images/placeholder-image.png"),
                                const Positioned(
                                    bottom: 5,
                                    left: 75,
                                    child: Text("Tap to select an image!"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 150,
                      child: DefaultButton(
                        text: "Save",
                        press: () async{
                          try {
                            bool result =  await  categoriesProvider.validateAndSubmit();
                            if (result){
                              Navigator.of(context).pushReplacementNamed(Routes.categoriesScreen);}
                            else{print("something went wrong");}
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getTabAddCategoriesScreen(BuildContext context) {
  return Consumer<CategoriesProvider>(builder: (context, categoriesProvider, child) {

    // categoriesProvider.categoryTitle
    TextFormField buildCategoryNameFormField() {
      return TextFormField(
        controller: categoriesProvider.categoryTitle,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Category Title",
          hintText: "Enter category title",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.title),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text(
              "Add Category",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 23,
                  color: Colors.black),
            ),

            Form(
              key: categoriesProvider.addCategoryFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  buildCategoryNameFormField(),
                  const SizedBox(height: 15),

                  categoriesProvider.selectedImage!=null ?

                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                      color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
                      height: 200, width: 350,
                      child: Padding(
                        padding:  const EdgeInsets.all(8.0),
                        child: Image.memory(categoriesProvider.selectedImage!, fit: BoxFit.contain,),
                      )
                  ):InkWell(
                    onTap: (){
                      categoriesProvider.selectImages();
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: SizedBox(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                          child: Stack(
                            children: [
                              Image.asset("assets/images/placeholder-image.png"),
                              const Positioned(
                                  bottom: 5,
                                  left: 75,
                                  child: Text("Tap to select an image!"))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 150,
                    child: DefaultButton(
                      text: "Save",
                      press: () async{
                        try {
                          bool result =  await  categoriesProvider.validateAndSubmit();
                          if (result){
                            Navigator.of(context).pushReplacementNamed(Routes.categoriesScreen);}
                          else{print("something went wrong");}
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });
}




Widget getDesktopAddCategoriesScreen() {
  return Consumer<CategoriesProvider>(builder: (context, categoriesProvider, child) {

   // categoriesProvider.categoryTitle
    TextFormField buildCategoryNameFormField() {
      return TextFormField(
        controller: categoriesProvider.categoryTitle,
        validator: (value) {
          if (value!.isEmpty) {
            return kPassNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Category Title",
          hintText: "Enter category title",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.title),
        ),
      );
    }


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                  height: MediaQuery.of(context).size.height,
                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        const Text(
                          "Add Category",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 23,
                              color: Colors.black),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Form(
                            key: categoriesProvider.addCategoryFormKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                buildCategoryNameFormField(),
                                const SizedBox(height: 15),

                                categoriesProvider.selectedImage!=null ?

                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
                                    height: 200, width: 350,
                                    child: Padding(
                                      padding:  const EdgeInsets.all(8.0),
                                      child: Image.memory(categoriesProvider.selectedImage!, fit: BoxFit.contain,),
                                    )
                                ):InkWell(
                                  onTap: (){
                                    categoriesProvider.selectImages();
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(12),
                                    padding: const EdgeInsets.all(6),
                                    child: SizedBox(
                                      width: 350,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                        child: Stack(
                                          children: [
                                            Image.asset("assets/images/placeholder-image.png"),
                                            const Positioned(
                                                bottom: 5,
                                                left: 75,
                                                child: Text("Tap to select an image!"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 35),
                                SizedBox(
                                  width: 150,
                                  child: DefaultButton(
                                    text: "Save",
                                    press: () async{
                                      try {
                                        bool result =  await  categoriesProvider.validateAndSubmit();
                                        if (result){
                                          Navigator.of(context).pushReplacementNamed(Routes.categoriesScreen);}
                                        else{print("something went wrong");}
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
