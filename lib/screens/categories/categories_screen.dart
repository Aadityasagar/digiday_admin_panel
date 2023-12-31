import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/no_data_view.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/components/default_button.dart';
import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/categories_provider.dart';
import 'package:digiday_admin_panel/routes.dart';
import 'package:digiday_admin_panel/screens/categories/edit_category_screen.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

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
                backgroundColor:  ColourScheme.backgroundColor,
                appBar: PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: HeaderWidget(opacity: _opacity),
                ),
                drawer: const ExploreDrawer(),
                body: ResponsiveWidget(
                  largeScreen: getDesktopCategoriesScreen(),
                  smallScreen: getMobileCategoriesScreen(context),
                  mediumScreen: getTabCategoriesScreen(context),
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


Widget getMobileCategoriesScreen(BuildContext context) {
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
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 200,
                    child: DefaultButton(
                      text: 'Add Category',
                      press: (){
                        Navigator.of(context).pushReplacementNamed(Routes.addCategoryScreen);
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            categoriesProvider.categoriesList.isNotEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child:
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  const TableRow(
                      decoration: BoxDecoration(color: kPrimaryColor),
                      children: [

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
                        /// Featured

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Featured",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// actions

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

                            /// image

                            Center(
                              child: categories.value?.categoryIcon==null ? Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("assets/images/ProfileImage.png", height: 60,),
                              ):
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(categories.value?.categoryIcon??"", height: 60, )
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

                            /// featured

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: InkWell(child: (categories.value.isFeatured??false) ? const Icon(Icons.star): const Icon(Icons.star_border),
                                  onTap: (){

                                    bool isFeatured= categories!.value!.isFeatured??false;
                                    if(categories.value!=null) {
                                      categoriesProvider.makeCategoryFeatured(categories.value.id!,(isFeatured?false:true));
                                    }

                                  },
                                ),
                              ),
                            ),

                            /// actions

                            Center(
                              child: IconButton(onPressed: (){
                                categoriesProvider.selectCategoryToEdit(categories.value);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditCategoryScreen()));
                              }
                              , icon: const Icon(Icons.edit, color: kPrimaryColor,)),
                            )
                          ]);
                    },
                  )
                ],
              ),
            )
                : const Center(
              child: Text('No Category Added'),
            ),
          ],
        ),
      ),
    );
  });
}

Widget getTabCategoriesScreen(BuildContext context) {
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

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 200,
                    child: DefaultButton(
                      text: 'Add Category',
                      press: (){
                        Navigator.of(context).pushReplacementNamed(Routes.addCategoryScreen);
                      },
                    ),
                  ),
                ),
              ],
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
                  4: FlexColumnWidth(),
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
                        /// Featured

                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Featured",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        /// actions

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
                                child: Image.asset("assets/images/ProfileImage.png", height: 60,),
                              ):
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(categories.value?.categoryIcon??"", height: 60, )
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
                            /// featured

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: InkWell(child: (categories.value.isFeatured??false) ? const Icon(Icons.star): const Icon(Icons.star_border),
                                  onTap: (){

                                    bool isFeatured= categories!.value!.isFeatured??false;
                                    if(categories.value!=null) {
                                      categoriesProvider.makeCategoryFeatured(categories.value.id!,(isFeatured?false:true));
                                    }

                                  },
                                ),
                              ),
                            ),

                            /// actions

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: MaterialButton(
                                  color: ColourScheme.buttonColor,
                                  onPressed:(){
                                    categoriesProvider.selectCategoryToEdit(categories.value);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditCategoryScreen()));
                                  },
                                  child: const Text("Edit"),
                                ),
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

Widget getDesktopCategoriesScreen() {
  return Consumer<CategoriesProvider>(builder: (context, categoriesProvider, child) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// blank space

                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height-100,
                  child: const SideBarMenu(),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
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
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      width: 200,
                                      child: DefaultButton(
                                        text: 'Add Category',
                                        press: (){
                                          Navigator.of(context).pushReplacementNamed(Routes.addCategoryScreen);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              categoriesProvider.categoriesList.isNotEmpty
                                  ? SizedBox(
                                child:
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(),
                                    3: FlexColumnWidth(),
                                    4: FlexColumnWidth(),
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

                                          /// Featured

                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                "Featured",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),

                                          /// actions

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
                                                  child: Image.asset("assets/images/ProfileImage.png", height: 60,),
                                                ):
                                                Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Image.network(categories.value?.categoryIcon??"", height: 60, )
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

                                              /// featured

                                               Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                  child: InkWell(child: (categories.value.isFeatured??false) ? const Icon(Icons.star): const Icon(Icons.star_border),
                                                   onTap: (){

                                                    bool isFeatured= categories!.value!.isFeatured??false;
                                                    if(categories.value!=null) {
                                                        categoriesProvider.makeCategoryFeatured(categories.value.id!,(isFeatured?false:true));
                                                    }

                                                   },
                                                  ),
                                                ),
                                              ),

                                               /// actions

                                               Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                  child: MaterialButton(
                                                    color: ColourScheme.buttonColor,
                                                    onPressed:(){
                                                      categoriesProvider.selectCategoryToEdit(categories.value);
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditCategoryScreen()));
                                                    },
                                                    child: const Text("Edit"),
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
                                child: Text('No Category Added'),
                              ),
                            ],
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