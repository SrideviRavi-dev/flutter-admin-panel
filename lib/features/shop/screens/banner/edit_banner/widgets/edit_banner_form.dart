// ignore_for_file: unused_local_variable

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/banner/edit_banner_controller.dart';
import 'package:admin/features/shop/models/banner_model.dart';
import 'package:admin/routes/app_screens.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});
  final BannerModel banner;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);

    return JRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(JSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: JSizes.sm,
            ),
            Text('Update  Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: JSizes.spaceBtwSections),
            Column(
              children: [
                Obx(
                  () => JRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: JColors.primaryBackground,
                    image: controller.imageURL.value.isNotEmpty
                        ? controller.imageURL.value
                        : JImages.photo,
                    imageType: controller.imageURL.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                TextButton(
                    onPressed: () => controller.pickImage(),
                    child: Text('Select Image')),
              ],
            ),
            const SizedBox(
              height: JSizes.spaceBtwInputFields,
            ),
            Text('Make Your Banner Action or InActive',
                style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) =>
                    controller.isActive.value = value ?? false,
                child: Text('Active'),
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            Obx(() {
              List<String> screens = AppScreens.allAppScreenItems;

              // Ensure targetScreen has a valid value
              if (!screens.contains(controller.targetScreen.value)) {
                controller.targetScreen.value =
                    screens.isNotEmpty ? screens.first : '';
              }

              return DropdownButton<String>(
                value: controller.targetScreen.value.isNotEmpty
                    ? controller.targetScreen.value
                    : null, // Avoid assertion failure
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.targetScreen.value = newValue;
                  }
                },
                items: screens.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: JSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateBanner(banner),
                  child: Text('Update')),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields * 2)
          ],
        ),
      ),
    );
  }
}
