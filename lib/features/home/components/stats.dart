
import 'package:digiday_admin_panel/constants.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   List<Stat> stats= [
     Stat(
       icon: Icons.insights_sharp,
       amount:"₹0",
       title: "Today's Sale",
       press: (){},
         color: Colors.green.shade600
     ),
     Stat(
         icon: Icons.bar_chart,
         amount:"₹0",
         title: 'Monthly Sale',
         press: (){},
         color: kPrimaryColor
     ),
     Stat(
         icon: Icons.discount_sharp,
         amount: '20% Discount',
         title: 'My Offers',
         press: (){},
         color: Colors.redAccent.shade200
     ),
     Stat(
         icon: Icons.shopping_cart,
         amount:"0",
         title: 'Orders',
         press: (){},
         color: Colors.orangeAccent.shade400
     ),




   ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: stats.length,
        itemBuilder: (BuildContext context, int index) {
          return StatsCard(
            icon: stats[index].icon,
            title: stats[index].title,
            press: stats[index].press,
            color: stats[index].color,
            amount: stats[index].amount,

          );
        }
    );
  }
}

class Stat{
  String title;
  String? amount;
  Color  color;
  IconData icon;
  VoidCallback press;



  Stat({
    required this.title,
    this.amount,
    required this.color,
    required this.icon,
    required this.press
  });
}

class StatsCard extends StatelessWidget {
  const StatsCard({
    Key? key,
    required this.icon,
    this.amount,
    required this.color,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String? title;
  final String? amount;
  final Color  color;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(180),
            height: getProportionateScreenHeight(180),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon,
                size: 50,
                color: Colors.white,),
                SizedBox(height: 5),
                Text(amount!, textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18
                  ),),
                Text(title!, textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white
                  ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
