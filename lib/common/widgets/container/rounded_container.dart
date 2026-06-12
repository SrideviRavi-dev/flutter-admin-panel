// ignore_for_file: deprecated_member_use

import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class JRoundedContainer extends StatelessWidget {
  const JRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = JSizes.cardRadiusLg,
    this.child,
    this.showBorder = false,
    this.borderColor = JColors.borderPrimary,
    this.backgroundColor = JColors.white,
    this.padding,
    this.margin,
    this.onTap,
    this.showShadow = true,
  });
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final bool showShadow;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: JColors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
          ]),
      child: child,
    );
  }
}
