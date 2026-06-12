import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class JLoaderAnimation extends StatelessWidget {
  const JLoaderAnimation({super.key, this.height = 300, this.width = 300});

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(JImages.loading, height: height, width: width),
          const SizedBox(height: JSizes.spaceBtwItems),
          const Text('Loading Your data....'),
        ],
      ),
    );
  }
}
