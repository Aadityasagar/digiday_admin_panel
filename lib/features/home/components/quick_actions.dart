import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/features/add_admin/add_admin_screen.dart';
import 'package:digiday_admin_panel/features/payouts/payout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    List<QuickAction> actions = [
      QuickAction(
          title: "Add Admin",
          icon: Icons.person_add_sharp,
          press: (){
        Get.to(AddAdminScreen());
      }),
      QuickAction(
          title: "Admins",
          icon: Icons.person_2_sharp,
          press: (){}),
      QuickAction(
          title: "Process Withdrawals",
          icon: Icons.monetization_on,
          press: (){
            Get.to(PayoutScreen());
          }),
      QuickAction(
          title: "Referer Someone",
          icon: Icons.share,
          press: (){})
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
      child: Row(
        children: [
          Expanded(child:  ListView.builder(
            scrollDirection: Axis.vertical,
              itemCount: actions.length,
              itemBuilder: (BuildContext context, int index) {
                return QuickActionsCard(
                  icon: actions[index].icon,
                  title: actions[index].title,
                  press: actions[index].press,

                );
              }
          ),)

        ]
      ),
    );
  }
}


class QuickAction{
  String title;
  IconData icon;
  VoidCallback press;
  
  QuickAction({
    required this.title,
    required this.icon,
    required this.press
});
}

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(15)),

        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 45,),
            ),
              SizedBox(width: 20),
              Text(title!, overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                  fontSize: 18
                ),),

                SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
