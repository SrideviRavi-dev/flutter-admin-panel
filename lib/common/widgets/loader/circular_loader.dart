import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class JCircularLoader extends StatelessWidget {
  const JCircularLoader({
    super.key,
    this.foregroundColor = JColors.white,
    this.backgroundColor = JColors.primary,
  });

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(JSizes.lg),
      decoration: BoxDecoration(color: backgroundColor,shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(color: foregroundColor,backgroundColor: Colors.transparent,),
      ),
    );
  }
}
