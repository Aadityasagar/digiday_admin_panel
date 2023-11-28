import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const SvgImage(this.assetName,{this.width,this.height,this.fit,this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit??BoxFit.contain,
      height: height,
      width: width,
      color: color,
    );
  }
}

class SvgIcon extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const SvgIcon(this.assetName,{this.width,this.height,this.fit,this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      fit: fit??BoxFit.contain,
      height: height,
      width: width,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}