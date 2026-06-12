import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Header
        IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: JSizes.spaceBtwItems),
        Text(JTexts.forgotPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: JSizes.spaceBtwItems),
        Text(JTexts.forgotPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: JSizes.spaceBtwItems * 2),
    
        /// Form
        Form(
            child: TextFormField(
          decoration: const InputDecoration(
              labelText: JTexts.email,
              prefixIcon: Icon(Iconsax.direct_right)),
        )),
        const SizedBox(height: JSizes.spaceBtwSections),
    
        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.toNamed(JRoutes.resetPassword,
                  parameters: {'email':'Jardion13@gmail.com'} ),
              child: const Text(JTexts.submit)),
        ),
    
        const SizedBox(height: JSizes.spaceBtwSections * 2),
      ],
    );
  }
}
