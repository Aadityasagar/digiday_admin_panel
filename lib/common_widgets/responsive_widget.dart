import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  ///Breakpoint for mobile screen
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 520;
  }

  ///Breakpoint for tab screen
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 520 &&
        MediaQuery.of(context).size.width <= 700;
  }

  ///Breakpoint for desktop screen
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 700;
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return largeScreen;
        } else if (constraints.maxWidth <= 700 &&
            constraints.maxWidth >= 520) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}