import 'package:digiday_admin_panel/size_config.dart';
import 'package:flutter/material.dart';

import '../account/view/components/body.dart';

class WalkThroughScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
