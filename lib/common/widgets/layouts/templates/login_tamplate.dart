import 'package:admin/common/styles/spacing_style.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class JLoginTamplate extends StatelessWidget {
  const JLoginTamplate({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: JSpacingStyle.paddingInAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(JSizes.cardRadiusLg),
              color: JHelperFunction.isDarkMode(context)? JColors.black: JColors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
