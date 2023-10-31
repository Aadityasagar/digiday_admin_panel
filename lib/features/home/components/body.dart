import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'quick_actions.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
         children: [
          SizedBox(height: getProportionateScreenHeight(10)),
         const HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
        const  Text('Quick Actions',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),),
           Expanded(child: QuickActions()),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
