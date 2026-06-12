// ignore_for_file: curly_braces_in_flow_control_structures, unused_element

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/common/widgets/loader/animation_loader.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:admin/features/media/screens/media/widgets/view_image_details.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImagessSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagessSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  Text('Select Folder',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(width: JSizes.spaceBtwItems),
                  MediaFolderDropdown(
                    onChanged: (MediaCategory? newValue) {
                      if (newValue != null) {
                        controller.selectedPath.value = newValue;
                        controller.getMediaImages();
                      }
                    },
                  )
                ],
              ),
              if (allowSelection) buildAddSelectedImagesButton(),
            ],
          ),
          const SizedBox(
            height: JSizes.spaceBtwSections,
          ),
          Obx(() {
            List<ImageModel> images = _getSelectedFolderImages(controller);

            
            if(!loadedPreviousSelection){
            if (alreadySelectedUrls != null &&
                alreadySelectedUrls!.isNotEmpty) {
               final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);
                 
               for(var image in images){
                image.isSelected.value = selectedUrlsSet.contains(image.url);
                if(image.isSelected.value){
                  selectedImages.add(image);
                }
               }  

            } else {
              for (var image in images) {
                image.isSelected.value = false;
              }
            }
            loadedPreviousSelection = true;
            }

            if (controller.loading.value && images.isEmpty)
              return const JLoaderAnimation();

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,

                  // spacing: JSizes.spaceBtwItems / 2,
                  // runSpacing: JSizes.spaceBtwItems / 2,
                  children: images
                      .map((image) => GestureDetector(
                            onTap: () => Get.dialog(ImagePopup(image: image)),
                            child: SizedBox(
                              width: 140,
                              height: 180,
                              child: Column(
                                children: [
                                  allowSelection
                                      ? _buildListWithCheckbox(image)
                                      : _buildSimpleList(image),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: JSizes.sm),
                                      child: Text(
                                        image.filename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: JSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: JSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: const Text('Load More'),
                            icon: const Icon(Iconsax.arrow_down),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JSizes.lg * 3),
      child: JAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select Your Desired Folder',
        animation: JImages.processingdata,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return JRoundedImage(
      width: 140,
      height: 140,
      padding: JSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: JSizes.spaceBtwItems / 2,
      backgroundColor: JColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        JRoundedImage(
          width: 140,
          height: 140,
          padding: JSizes.sm,
          image: image.url,
          imageType: ImageType.network,
          margin: JSizes.spaceBtwItems / 2,
          backgroundColor: JColors.primaryBackground,
        ),
        Positioned(
            top: JSizes.md,
            right: JSizes.md,
            child: Obx(
              () => Checkbox(
                value: image.isSelected.value,
                onChanged: (selected) {
                  if (selected != null) {
                    image.isSelected.value = selected;
                    if (selected) {
                      if (!allowMultipleSelection) {
                        for (var otherImage in selectedImages) {
                          if (otherImage != image) {
                            otherImage.isSelected.value = false;
                          }
                        }
                        selectedImages.clear();
                      }
                      selectedImages.add(image);
                    } else {
                      selectedImages.remove(image);
                    }
                  }
                },
              ),
            ))
      ],
    );
  }

  Widget buildAddSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
              onPressed: () => Get.back(),
              label: const Text('Close'),
              icon: const Icon(Iconsax.close_circle)),
        ),
        const SizedBox(width: JSizes.spaceBtwItems),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
            onPressed: () => Get.back(result: selectedImages),
          ),
        )
      ],
    );
  }
}
