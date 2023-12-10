import 'package:digiday_admin_panel/common_widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: const EdgeInsets.all(30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.grey.shade100,
        ),
        onPressed: press,
        child: Row(
          children: [

            ResponsiveWidget.isMediumScreen(context)?
            Icon(
              icon,
              color: kPrimaryColor,
              size: MediaQuery.of(context).size.width / 50,
            ):Icon(
              icon,
              color: kPrimaryColor,
              size: ResponsiveWidget.isSmallScreen(context)? MediaQuery.of(context).size.width / 30:
              MediaQuery.of(context).size.width / 60,
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(text,
                    style: ResponsiveWidget.isMediumScreen(context)? TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 50,
                    ):TextStyle(
                      fontSize: ResponsiveWidget.isSmallScreen(context)? MediaQuery.of(context).size.width / 30:
                      MediaQuery.of(context).size.width / 120,
                    )
                )),

            ResponsiveWidget.isMediumScreen(context)?
            Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.width / 60,
            ):Icon(
              Icons.arrow_forward_ios,
              size: ResponsiveWidget.isSmallScreen(context)? MediaQuery.of(context).size.width / 40:
              MediaQuery.of(context).size.width / 80,
            ),
          ],
        ),
      ),
    );
  }
}

