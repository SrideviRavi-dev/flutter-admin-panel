// ignore_for_file: unused_element

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      required this.additionalProductImagesURLs,
      this.onTapToAddImages,
      this.onTapToRemoveImages});

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 300,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onTapToAddImages,
                  child: JRoundedContainer(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(JImages.logo, width: 50, height: 50),
                          const Text('Add Additional Product Images'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Row(children: [
                Expanded(
                  flex: 2,
                    child: SizedBox(
                  height: 80,
                  child: Obx(() {
                      return additionalProductImagesURLs.isEmpty
                          ? emptyList() // Show placeholders if no images
                          : _uploadedImages(); // Show uploaded images
                    }),
                )),
                const SizedBox(width: JSizes.spaceBtwItems / 2),
                JRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: JColors.grey,
                  backgroundColor: JColors.white,
                  onTap: onTapToAddImages,
                  child: const Center(child: Icon(Iconsax.add)),
                ),
              ]))
            ],
          ),
        );
  }

  Widget _uploadedImagesOrEmptyList() {
    return emptyList();
  }

  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) =>
          const SizedBox(width: JSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) => const JRoundedContainer(
          backgroundColor: JColors.primaryBackground, width: 80, height: 80),
    );
  }

  ListView _uploadedImages() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: additionalProductImagesURLs.length,
      separatorBuilder: (context, index) =>
          const SizedBox(width: JSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return JImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          image: image,
          icon: Iconsax.trash,
          imageType: ImageType.network,
          onIconButtonPressed: () => onTapToRemoveImages!(index),
        );
      },
    );
  }
}
