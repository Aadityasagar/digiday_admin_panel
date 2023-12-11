import 'package:digiday_admin_panel/common_widgets/drawer/explore_drawer.dart';
import 'package:digiday_admin_panel/common_widgets/header_widget.dart';
import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:digiday_admin_panel/common_widgets/sidebar_menu.dart';
import 'package:digiday_admin_panel/constants/colour_scheme.dart';
import 'package:digiday_admin_panel/provider/cms_provider.dart';
import 'package:digiday_admin_panel/screens/common/widgets/app_themed_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CmDetailsScreen extends StatelessWidget {
  CmDetailsScreen({super.key});

  double _opacity = 0;
  final double _scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Consumer<CmProvider>(
        builder: (context,cmProvider,child) {
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
                  largeScreen: getDesktopCmDetailsScreen(),
                  smallScreen: getMobileCmDetailsScreen(context),
                  mediumScreen: getTabCmDetailsScreen(context),
                ),
              ),
              Offstage(
                  offstage: !cmProvider.isLoading,
                  child: const AppThemedLoader())
            ],
          );
        }
    );
  }
}

Widget getMobileCmDetailsScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 10,),
                    /// image

                    Center(
                      child: cmProvider.selectedCm?.photo==null ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/ProfileImage.png"),
                          radius: 100,
                        ),
                      ):
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                            radius: 100,
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    /// name

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person),
                        Text(
                          '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    /// address

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.location_solid),
                        Text(
                          "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""}",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],),
              ),
            ),

            const SizedBox(height: 15),

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text("Is Subscriber:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                        fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(width: 5),

                    Text(
                      cmProvider.selectedCm?.isSubscribed==true? "Yes":
                      "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                        fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),),

            const SizedBox(height: 15),

            /// verifications

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    /// email verified

                    Row(
                      children: [
                        Text("Email Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          cmProvider.selectedCm?.emailVerified==true? "Yes":
                          "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    /// Phone verified

                    Row(
                      children: [
                        Text("Phone Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          cmProvider.selectedCm?.phoneVerified==true? "Yes":
                          "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),



                  ],),
              ),),

            const SizedBox(height: 15),

            /// Circle Manager details

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
                child: Column(
                  children: [

                    Text('Circle Manager Details', style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width/30),),

                    const SizedBox(height: 10,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// first name
                            Row(
                              children: [
                                Text('First Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  '${cmProvider.selectedCm?.firstName}', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),

                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// email
                            Row(
                              children: [
                                Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.email ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// referred by

                            Row(
                              children: [
                                Text('Referred By:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.referredBy ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                          ],),

                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// last name

                            Row(
                              children: [
                                Text('Last Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),

                                Text(
                                  '${cmProvider.selectedCm?.lastName}',
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// phone

                            Row(
                              children: [
                                Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.phone ?? "",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),


                            /// Referral Code

                            Row(
                              children: [
                                Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(cmProvider.selectedCm!.referralCode?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                                    fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),
                          ],),
                      ],
                    ),



                  ],),
              ),
            ),

            const SizedBox(height: 15),

            /// address

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Address:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                        fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(width: 5),
                    Text(
                      "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""} ${cmProvider.selectedCm?.state ?? ""} ${cmProvider.selectedCm?.pinCode ??""}",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/35,
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),),
          ],
        ),
      ),
    ):const Text("No Cm selected!");
  });
}

Widget getTabCmDetailsScreen(BuildContext context) {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(height: 10,),
                    /// image

                    Center(
                      child: cmProvider.selectedCm?.photo==null ? const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/ProfileImage.png"),
                          radius: 100,
                        ),
                      ):
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                            radius: 100,
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    /// name

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person),
                        Text(
                          '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    /// address

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.location_solid),
                        Text(
                          "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""}",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),


                  ],),
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                /// subscriber or not

                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:75, vertical: 20),
                    child: Row(
                      children: [
                        Text("Is Subscriber:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          cmProvider.selectedCm?.isSubscribed==true? "Yes":
                          "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                            fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),),

                const SizedBox(width: 20),

                /// verifications

                Flexible(
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                    child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          /// email verified

                          Row(
                            children: [
                              Text("Email Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w600),
                              ),

                              const SizedBox(width: 5),

                              Text(
                                cmProvider.selectedCm?.emailVerified==true? "Yes":
                                "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          /// Phone verified

                          Row(
                            children: [
                              Text("Phone Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w600),
                              ),

                              const SizedBox(width: 5),

                              Text(
                                cmProvider.selectedCm?.phoneVerified==true? "Yes":
                                "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                  fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),



                        ],),
                    ),),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// Circle Manager details

            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
                child: Column(
                  children: [

                    Text('Circle Manager Details', style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width/45),),

                    const SizedBox(height: 10,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// first name
                            Row(
                              children: [
                                Text('First Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  '${cmProvider.selectedCm?.firstName}',
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),

                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// email
                            Row(
                              children: [
                                Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.email ?? "",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// referred by

                            Row(
                              children: [
                                Text('Referred By:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.referredBy ?? "",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                          ],),

                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// last name

                            Row(
                              children: [
                                Text('Last Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 5),

                                Text(
                                  '${cmProvider.selectedCm?.lastName}',
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// phone

                            Row(
                              children: [
                                Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  cmProvider.selectedCm?.phone ?? "",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            /// Referral Code

                            Row(
                              children: [
                                Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                    fontWeight: FontWeight.w600),
                                ),

                                const SizedBox(width: 5),

                                Text(cmProvider.selectedCm!.referralCode?? "",
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),
                          ],),
                      ],
                    ),



                  ],),
              ),
            ),

            const SizedBox(height: 15),

            /// address

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child:
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Address:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                        fontWeight: FontWeight.w600),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,

                    ),

                    const SizedBox(width: 5),
                    Text(
                      "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""} ${cmProvider.selectedCm?.state ?? ""} ${cmProvider.selectedCm?.pinCode ??""}",
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/50,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),),


            const SizedBox(height: 15),

          ],
        ),
      ),
    ):const Text("No Cm selected!");
  });
}

Widget getDesktopCmDetailsScreen() {
  return Consumer<CmProvider>(builder: (context, cmProvider, child) {
    return cmProvider.selectedCm!=null? SingleChildScrollView(
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
                Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 15,),

                        Row(
                          children: [

                            /// image container

                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                                child: Column(children: [
                                  /// image

                                  Center(
                                    child: cmProvider.selectedCm?.photo==null ? const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("images/ProfileImage.png"),
                                        radius: 60,
                                      ),
                                    ):
                                    Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(cmProvider.selectedCm?.photo ?? ""),
                                          radius: 60,
                                        )
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  /// name

                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Text(
                                        '${cmProvider.selectedCm?.firstName} ${cmProvider.selectedCm?.lastName}',
                                      ),
                                    ],
                                  ),

                                  /// address

                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.location_solid),
                                      Text(
                                          "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""}"
                                      ),
                                    ],
                                  ),
                                ],),
                              ),
                            ),
                            const SizedBox(width: 20,),

                            Expanded(
                              child: Column(
                                children: [

                                  /// Circle Manager details
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
                                      child: Column(
                                        children: [

                                          Text('Circle Manager Details', style: TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.width/60),),

                                          const SizedBox(height: 10,),

                                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /// first name
                                                  Row(
                                                    children: [
                                                      Text('First Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),

                                                      const SizedBox(width: 5),

                                                      Text(
                                                        '${cmProvider.selectedCm?.firstName}', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),

                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),

                                                  /// email
                                                  Row(
                                                    children: [
                                                      Text('Email:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),

                                                      const SizedBox(width: 5),

                                                      Text(
                                                        cmProvider.selectedCm?.email ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),

                                                  /// referred by

                                                  Row(
                                                    children: [
                                                      Text('Referred By:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),

                                                      const SizedBox(width: 5),

                                                      Text(
                                                        cmProvider.selectedCm?.referredBy ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),

                                                ],),

                                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /// last name

                                                  Row(
                                                    children: [
                                                      Text('Last Name:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),
                                                      const SizedBox(width: 5),

                                                      Text(
                                                        '${cmProvider.selectedCm?.lastName}', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),

                                                  /// phone

                                                  Row(
                                                    children: [
                                                      Text('Phone:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),

                                                      const SizedBox(width: 5),

                                                      Text(
                                                        cmProvider.selectedCm?.phone ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),

                                                  /// Referral Code

                                                  Row(
                                                    children: [
                                                      Text('Referral Code:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w600),
                                                      ),

                                                      const SizedBox(width: 5),

                                                      Text(cmProvider.selectedCm!.referralCode?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                                          fontWeight: FontWeight.w400),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        softWrap: true,
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 10,),
                                                ],),
                                            ],
                                          ),



                                        ],),
                                    ),
                                  ),


                                  const SizedBox(height: 15),

                                  /// address

                                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                    child:


                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Address:', style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w600),
                                          ),

                                          const SizedBox(width: 5),
                                          Text(
                                            "${cmProvider.selectedCm?.address ?? ""} ${cmProvider.selectedCm?.city ?? ""} ${cmProvider.selectedCm?.state ?? ""} ${cmProvider.selectedCm?.pinCode ??""}",
                                            style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w400),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),)
                                ],
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 15),

                        Row(
                          children: [
                            /// subscriber or not

                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                              child:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:75, vertical: 20),
                                child: Row(
                                  children: [
                                    Text("Is Subscriber:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                        fontWeight: FontWeight.w600),
                                    ),

                                    const SizedBox(width: 5),

                                    Text(
                                      cmProvider.selectedCm?.isSubscribed==true? "Yes":
                                      "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                        fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),),

                            const SizedBox(width: 20),

                            /// verifications

                            Flexible(
                              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:20, vertical: 20),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [

                                      /// email verified

                                      Row(
                                        children: [
                                          Text("Email Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w600),
                                          ),

                                          const SizedBox(width: 5),

                                          Text(
                                            cmProvider.selectedCm?.emailVerified==true? "Yes":
                                            "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),


                                      /// Phone verified

                                      Row(
                                        children: [
                                          Text("Phone Verified:", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w600),
                                          ),

                                          const SizedBox(width: 5),

                                          Text(
                                            cmProvider.selectedCm?.phoneVerified==true? "Yes":
                                            "No", style: TextStyle(fontSize: MediaQuery.of(context).size.width/90,
                                              fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),



                                    ],),
                                ),),
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
    ):const Text("No CM selected!");
  });
}
