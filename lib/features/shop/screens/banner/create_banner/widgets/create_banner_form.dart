import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/banner/create_banner_controller.dart';
import 'package:admin/routes/app_screens.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
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
            Text('Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: JSizes.spaceBtwSections),
            Column(
              children: [
                Obx(
                ()=> GestureDetector(
                    child: JRoundedImage(
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
            Text('Make your Banner Active or inActive',
                style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) =>
                    controller.isActive.value = value ?? false,
                child: const Text('Active'),
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            Obx(
              (){
                return DropdownButton<String>(
                value: controller.targetScreen.value,
                onChanged: (String? newValue) => controller.targetScreen.value = newValue!,
                items:  AppScreens.allAppScreenItems.map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem<String>(value:value,
                   child: Text(value));
                }).toList(),
              );
              } 
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields * 2),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.createBanner(), child: Text('Create')),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields * 2)
          ],
        ),
      ),
    );
  }
}
