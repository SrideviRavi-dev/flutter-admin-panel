import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header
        IconButton(
            onPressed: () => Get.offAllNamed(JRoutes.login),
            icon: const Icon(CupertinoIcons.clear)),
        const SizedBox(height: JSizes.spaceBtwItems),

        // Image
        const Image(
            image: AssetImage(JImages.emailSend), width: 300, height: 300),
        const SizedBox(height: JSizes.spaceBtwItems),

        // Title & Subtitle
        Text(JTexts.changeYourPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: JSizes.spaceBtwItems),
        Text(email,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: JSizes.spaceBtwItems),
        Text(JTexts.changeYourPasswordSubTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: JSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.offAllNamed(JRoutes.login),
              child: const Text(JTexts.done)),
        ),
        const SizedBox(height: JSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {}, child: const Text(JTexts.resendEmail)),
        ),
      ],
    );
  }
}
