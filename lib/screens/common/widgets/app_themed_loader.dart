import 'package:digiday_admin_panel/constants.dart';
import 'package:flutter/material.dart';

class AppThemedLoader  extends StatelessWidget {
  const AppThemedLoader({Key? key,this.isTransparent = false}) : super(key:key);
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: isTransparent ? Colors.transparent : Colors.black.withOpacity(0.4),
      child:  const CircularProgressIndicator(
        // color: Colors.red,
        valueColor:AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ),
    );
  }
}

class AppThemedLoaderLinear  extends StatelessWidget {
  final bool isTransparent;
  const AppThemedLoaderLinear({Key? key,this.isTransparent = false}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return  LinearProgressIndicator(backgroundColor: Theme.of(context).colorScheme.primary,);
  }
}
