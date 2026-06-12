import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/features/personalization/controllers/settings_controller.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget { 
  const  ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return JRoundedContainer(
      padding: const EdgeInsets.symmetric(
          vertical: JSizes.lg, horizontal: JSizes.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => JImageUploader(
              right: 10,
              bottom: 20,
              left: null,
              width: 200,
              height: 200,
              circular: true,
              icon: Iconsax.camera,
              loading: controller.loading.value,
              onIconButtonPressed: () => controller.updateAppLogo(),
              imageType: controller.settings.value.appLogo.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              image: controller.settings.value.appLogo.isNotEmpty
                  ? controller.settings.value.appLogo
                  : JImages.logo, 
            ),
          ),
          const SizedBox(height: JSizes.spaceBtwItems),
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => Text(controller.settings.value.appName,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
