import 'package:digiday_admin_panel/constants.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/app_themed_chip_button.dart';
import 'package:digiday_admin_panel/screens/common/widgets/alerts-and-popups/svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PopupType {success,warning,error,info}

class ActionButton {
  String title;
  VoidCallback onTap;
  @Deprecated("No need to pass color as pop button will automaticaly decide button color on the bases of no of button passed ")
  Color? btnColor;
  PopupType? type;

  ActionButton(this.title, this.onTap,{this.btnColor,this.type});
}

class AppThemedPopup extends StatelessWidget {
  final String? message;
  final String? title;
  final PopupType? type;
  final List<ActionButton> actions;

  const AppThemedPopup(
      {this.title, this.message,this.type, this.actions = const [], Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: getCustomAlert(context),
    );
  }

  Widget getCustomAlert(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).popupMenuTheme.color,
      insetPadding:  const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width*0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
                visible: type!=null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Icon(type?.getType,color: type?.getColor,size: 50,),
                )),
            Visibility(
              visible: title!=null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Visibility(
              visible: message!=null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(message ?? "",
                  textAlign: TextAlign.center
                ),
              ),
            ),


            Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                    actions.length,
                        (index) => AppThemedChipButton(
                      minSize: const Size(80,40),
                      onTap: actions[index].onTap,
                      btnColor: index % 2 == 0 ? null : Theme.of(context).colorScheme.secondary,  //actions[index].btnColor,
                      title: actions[index].title,
                    )



                ))
          ],
        ),
      ),
    );
  }


}

class AppThemedDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final PopupType? type;
  final List<ActionButton> actions;

  const AppThemedDialog(
      {this.title, this.message,this.type, this.actions = const [], Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: getCustomAlert());
  }

  Widget getCustomAlert() {
    return AlertDialog(
      insetPadding:  const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width*0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visibility(
            //     visible: type!=null,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 12.0),
            //       child: Icon(type?.getType,color: type?.getColor,size: 50,),
            //     )),

            Center(
              child: Visibility(
                visible: title!=null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    title ?? "",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),


                  ),
                ),
              ),
            ),

            Visibility(
              visible: message!=null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(message ?? "",),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  alignment: WrapAlignment.end,
                  children: List.generate(
                      actions.length,
                          (index) => TextButton(
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact
                        ),
                        onPressed:actions[index].onTap,
                        child: Text(
                          actions[index].title,
                        ),
                      )
                  )),
            )
          ],
        ),
      ),
    );
  }
}

//Dialog with svg image
class AppThemedDialogWithSvg extends StatelessWidget {
  final String? message;
  final String? title;
  final String svg;
  final PopupType? type;
  final List<ActionButton> actions;

  const AppThemedDialogWithSvg(
      {this.title,required this.svg, this.message,this.type, this.actions = const [], Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: getCustomAlert());
  }

  Widget getCustomAlert() {
    return AlertDialog(
      insetPadding:  const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: Get.width*0.50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SvgImage(
                svg,
              ),
            ),
            const Divider(color: kPrimaryColor,thickness: 1,indent: 30,endIndent: 30,),
            const SizedBox(height: 5,),
            Visibility(
              visible: title!=null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  title ?? ""/*,textAlign: TextAlign.center*/,
                ),
              ),
            ),

            Visibility(
              visible: message!=null,

              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),

                child: Text(message ?? "",/*textAlign: TextAlign.center,*/),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 50,top: 10),
              child: Wrap(
                  runSpacing: 10,
                  spacing: 35,
                  alignment: WrapAlignment.end,
                  children: List.generate(
                      actions.length,
                          (index) => InkWell(
                        onTap:actions[index].onTap,
                        child: Text(actions[index].title,style: TextStyle(fontWeight:FontWeight.bold,color: actions[index].btnColor??kPrimaryColor),),
                      )
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget getCupertinoAlert() {
    return CupertinoAlertDialog(
      title: Text(title ?? ""),
      content: Text(message ?? ""),
      actions: List.generate(
          actions.length,
              (index) => CupertinoDialogAction(
            onPressed: actions[index].onTap,
            child: Text(
              actions[index].title,
              style: const TextStyle(color: kPrimaryColor),
            ),
          )),
    );
  }

  getAlert() {
    AlertDialog(
      content: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          message ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(color: kPrimaryColor, fontSize: 18),
        ),
      ),
      actions: List.generate(
        actions.length,
            (index) => TextButton(
          onPressed: actions[index].onTap,
          child: Text(
            actions[index].title,
          ),
        ),
      ),
    );
  }

}


extension PopupExtension on PopupType{

  IconData get getType {
    switch (this) {
      case PopupType.success:
        return CupertinoIcons.check_mark_circled; //Icons.check_circle_outlined;
        break;
      case PopupType.warning:
        return CupertinoIcons.exclamationmark_triangle; //Icons.warning_amber;
        break;
      case PopupType.error:
        return CupertinoIcons.exclamationmark_circle;
        break;
      case PopupType.info:
        return CupertinoIcons.info;
        break;
    }
  }

  Color get getColor {
    switch (this) {
      case PopupType.success:
        return Colors.green;
        break;
      case PopupType.warning:
        return Colors.orange;
        break;
      case PopupType.error:
        return Colors.red;
        break;
      case PopupType.info:
        return kPrimaryColor;
        break;
    }
  }
}
