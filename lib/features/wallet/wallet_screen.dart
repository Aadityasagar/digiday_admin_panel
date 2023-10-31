import 'package:digiday_admin_panel/constants.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet", style: headingStyle,),
      ),
      body: Body(),
    );
  }
}
