import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageAdapter {
  static Widget fromAsset(
    String path, {
    Key? key,
    double? height,
    double? width,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      path,
      key: key,
      height: height,
      width: width,
      color: color,
      alignment: alignment,
      fit: fit,
    );
  }
}
