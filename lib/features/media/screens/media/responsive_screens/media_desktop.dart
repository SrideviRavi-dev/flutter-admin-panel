import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/screens/media/widgets/media_content.dart';
import 'package:admin/features/media/screens/media/widgets/media_uploader.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const JBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [
                      'Media Screen',
                    ],
                  ),
                  SizedBox(
                    width: JSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showImagesUploaderSection
                          .value = !controller.showImagesUploaderSection.value,
                      icon: const Icon(Iconsax.cloud_add),
                      label: const Text('Upload Images'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              const MediaUploader(),
               MediaContent(allowSelection: false, allowMultipleSelection: false,),
            ],
          ),
        ),
      ),
    );
  }
}
