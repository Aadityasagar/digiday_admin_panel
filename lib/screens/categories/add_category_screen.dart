import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/provider/categories_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
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
    TextFormField buildCategoryNameFormField() {
      return TextFormField(
        controller: categoriesProvider.categoryTitle,
        decoration: const InputDecoration(
          labelText: "Category Name",
          hintText: "Enter Category Name",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Enter Complete Category details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),

            Form(
              key: categoriesProvider.addCategoryFormKey,
              child: Column(
                children: [
                  /// category name

                  buildCategoryNameFormField(),



                  /// category icon

                  const SizedBox(height: 15),

                  categoriesProvider.selectedImage!=null ?

                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                      color: Colors.white, border: Border.all(width: 1, color: Colors.grey.shade700)),
                      height: 200, width: 350,
                      child: Padding(
                        padding:  const EdgeInsets.all(8.0),
                        child: Image.network(categoriesProvider.selectedImage!, fit: BoxFit.contain,),
                      )
                  ):const SizedBox(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                    child: DefaultButton(
                      text:  categoriesProvider.selectedImage==null && categoriesProvider.selectedImage!=null ? "Change Image": "Add Image",
                      press: (){
                        categoriesProvider.selectImages();
                      },
                    ),
                  ),
                  const SizedBox(height: 35),
                  DefaultButton(
                    text: "Add Category",
                    press: () async{
                 try {
                   bool result=  await  categoriesProvider.validateAndSubmit();

                   if (result){Navigator.of(context).pushReplacementNamed(Routes.categoriesScreen);}
                                    else{print("something went wrong");}
                 } catch (e) {
                   print(e);
                 }


                    },
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

Widget getTabAddCategoriesScreen(BuildContext context) {
  return Consumer<CategoriesProvider>(builder: (context, categoriesProvider, child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Categories",
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
              child: categoriesProvider.categoriesList.isNotEmpty
                  ? Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
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

                        /// title

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Title",
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
                  ...categoriesProvider.categoriesList.asMap().entries.map(
                        (categories) {
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
                                  "${categories.key + 1}",
                                ),
                              ),
                            ),

                            /// image

                            Center(
                              child: categories.value?.categoryIcon==null ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("images/ProfileImage.png"),
                              ):
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(categories.value?.categoryIcon??"")
                              ),
                            ),

                            /// title

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Text(categories.value.categoryName??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),

                            /// action

                            Center(
                              child: DropdownButton<String>(
                                icon: const Icon(CupertinoIcons.chevron_down_circle, color: kPrimaryColor,),
                                style: const TextStyle(color: kPrimaryColor),
                                underline: Container(
                                  height: 0,
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
                          ]);
                    },
                  )
                ],
              )
                  : const Center(
                child: Text('No category Added'),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Categories",
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
                            categoriesProvider.categoriesList.isNotEmpty
                                ? Table(
                              columnWidths: const {
                                0: FlexColumnWidth(),
                                1: FlexColumnWidth(),
                                2: FlexColumnWidth(),
                                3: FlexColumnWidth(),
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

                                      /// title

                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "Title",
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
                                ...categoriesProvider.categoriesList.asMap().entries.map(
                                      (categories) {
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
                                                "${categories.key + 1}",
                                              ),
                                            ),
                                          ),

                                          /// image

                                          Center(
                                            child: categories.value?.categoryIcon==null ? Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image.asset("images/ProfileImage.png"),
                                            ):
                                            Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Image.network(categories.value?.categoryIcon??"", height: 80,)
                                            ),
                                          ),

                                          /// title

                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(categories.value.categoryName??"",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),


                                          /// action

                                          Center(
                                            child: DropdownButton<String>(
                                              icon: const Icon(CupertinoIcons.chevron_down_circle, color: kPrimaryColor,),
                                              style: const TextStyle(color: kPrimaryColor),
                                              underline: Container(
                                                height: 0,
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
