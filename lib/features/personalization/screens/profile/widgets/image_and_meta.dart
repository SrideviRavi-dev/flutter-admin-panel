import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/features/authentication/controller/user_controller.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return JRoundedContainer(
      padding: const EdgeInsets.symmetric(vertical: JSizes.lg, horizontal: JSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:  Obx(
              ()=> JImageUploader(
                right: 10,
                bottom:20 ,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
                loading: controller.loading.value,
                onIconButtonPressed: ()=> controller.updateProfilePicture(),
                imageType:controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                image:controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture: JImages.user,
                ),
            ),
          ),
            const SizedBox(height: JSizes.spaceBtwItems),
            Obx(()=>Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineLarge)),
            Obx(()=> Text(controller.user.value.email)),
            const SizedBox(height: JSizes.spaceBtwSections),
        ],
      ),
    );
  }
}