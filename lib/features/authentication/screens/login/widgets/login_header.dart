import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class JLoginHeader extends StatelessWidget {
  const JLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
              width: 100,
              height: 100,
              image: AssetImage(JImages.logo)),
          const SizedBox(height: JSizes.spaceBtwSections),
          Text(JTexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: JSizes.sm),
          Text(JTexts.loginsubTitle,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}


