import 'package:admin/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class JCircularContainer extends StatelessWidget {
  const JCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding ,
    this.margin,
    this.child,
    this.backgroundColor,
    this.showBorder = false,
    this.borderColor = JColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding:  padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor): null,
        color: backgroundColor
      ),
      child: child,
    );
  }
}
