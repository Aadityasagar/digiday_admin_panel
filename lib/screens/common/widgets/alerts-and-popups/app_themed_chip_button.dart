import 'package:flutter/material.dart';

typedef VoidOnTap = void Function();

class AppThemedChipButton extends StatelessWidget {
  final String? title;
  final Color? btnColor;
  final Size minSize;

  final Widget? child;
  final VoidOnTap? onTap;
  final double verticalPadding;

  const AppThemedChipButton(
      {Key? key,
        this.title,
        this.onTap,
        this.child,
        this.btnColor,
        this.verticalPadding = 12.0,
        this.minSize = const Size(30, 40)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0.2,
        minimumSize: minSize,
        backgroundColor: btnColor,
      ),
      child: Text(
        title ?? "",
        maxLines: 1,
      ),
    );
  }
}
