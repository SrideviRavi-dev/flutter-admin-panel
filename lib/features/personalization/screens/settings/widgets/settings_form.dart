import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/personalization/controllers/settings_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        JRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: JSizes.lg, horizontal: JSizes.md),
          child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('App Settings',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: JSizes.spaceBtwSections),
                  TextFormField(
                    controller: controller.appNameController,
                    decoration: const InputDecoration(
                      hintText: 'App Name',
                      label: Text('App Name'),
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.taxController,
                          decoration: const InputDecoration(
                            hintText: 'Tax %',
                            label: Text('Tax Rate (%)'),
                          ),
                        ),
                      ),
                      const SizedBox(width: JSizes.spaceBtwItems),
                      Expanded(
                        child: TextFormField(
                          controller: controller.shippingController,
                          decoration: const InputDecoration(
                            hintText: 'Shipping Cost',
                            label: Text('Shipping Cost(\$)'),
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        ),
                      ),
                      const SizedBox(width: JSizes.spaceBtwItems),
                      Expanded(
                        child: TextFormField(
                          controller:
                              controller.freeShippingThresholdController,
                          decoration: const InputDecoration(
                            hintText: 'Free Shipping After(\$)',
                            label: Text('Free Shipping Threshold(\$)'),
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: JSizes.spaceBtwInputFields * 2),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                     ()=>  ElevatedButton(
                          onPressed: () => controller.loading.value
                              ? () {}
                              : controller.updateSettingInformation(),
                          child: controller.loading.value 
                              ? const CircularProgressIndicator(
                                  color: Colors.white, 
                                  strokeWidth: 2,
                                )
                              : const Text('Update App Settings')),
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
