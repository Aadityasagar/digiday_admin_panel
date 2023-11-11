import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/logo-rec.png", width: 120, ),
          
          Row(
            children: [
              // InkWell(onTap: (){
              //   Get.to(WalletScreen());
              //
              // },
              //   child: Container(
              //     height: getProportionateScreenWidth(46),
              //     width: getProportionateScreenWidth(46),
              //     decoration: BoxDecoration(
              //       color: kSecondaryColor.withOpacity(0.1),
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Icon(Icons.wallet,
              //       color: kPrimaryColor,
              //       size: 30,)),
              // ),

              SizedBox(width: getProportionateScreenWidth(10),),
              IconBtnWithCounter(
                icon: Icons.notifications,
                numOfitem: 3,
                press: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
