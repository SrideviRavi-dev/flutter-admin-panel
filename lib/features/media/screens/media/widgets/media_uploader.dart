// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:typed_data';

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';


class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                JRoundedContainer(
                  showBorder: true,
                  height: 250,
                  borderColor: JColors.borderPrimary,
                  backgroundColor: JColors.primaryBackground,
                  padding: const EdgeInsets.all(JSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DropzoneView(
                            mime: const ['image/jpeg', 'image/png'],
                            cursor: CursorType.Default,
                            operation: DragOperation.copy,
                            onLoaded: () => print('Zone loaded'),
                            onError: (ev) => print('Zone error: $ev'),
                            onHover: () => print('Zone Hover'),
                            onLeave: () => print('Zone left'),
                            onCreated: (ctrl) =>
                                controller.dropzoneController = ctrl,
                            onDropInvalid: (ev) =>
                                print('Zone invalid MIME: $ev'),
                            onDropMultiple: (ev) =>
                                print('Zone drop multiple: $ev'),
                            onDrop: (file) async {
                              if (file is DropzoneFileInterface) {
                                final bytes = await controller
                                    .dropzoneController
                                    .getFileData(file);
                                final image = ImageModel(
                                  url: '',
                                  file: file,
                                  folder: '',
                                  filename: file.name,
                                  localImageToDisplay:
                                      Uint8List.fromList(bytes),
                                );
                                controller.selectedImagesToUpload.add(image);
                              } else if (file is String) {
                                print('Zone drop: $file');
                              } else {
                                print('Zone unknown type:${file.runtimeType}');
                              }
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                JImages.photo,
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: JSizes.spaceBtwItems),
                              const Text('Drag and Drop Image here'),
                              const SizedBox(height: JSizes.spaceBtwItems),
                              OutlinedButton(
                                  onPressed: () async {
                                    // Call the selectLocalImages method using the already created instance
                                    await controller.selectLocalImages();
                                  },
                                  child: const Text('Select Images')),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
                if (controller.selectedImagesToUpload.isNotEmpty)
                  JRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Select Folder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(width: JSizes.spaceBtwItems),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () => controller
                                            .selectedImagesToUpload
                                            .clear(),
                                        child: const Text('Remove All')),
                                    const SizedBox(width: JSizes.spaceBtwItems),
                                    JDeviceUtils.isMobileScreen(context)
                                        ? const SizedBox.shrink()
                                        : SizedBox(
                                            width: JSizes.buttonWidth,
                                            child: ElevatedButton(
                                                onPressed: () => controller
                                                    .uploadImagesConfrimation(),
                                                child: const Text('Upload')),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: JSizes.spaceBtwItems),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: JSizes.spaceBtwItems / 2,
                          runSpacing: JSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                  (image) => image.localImageToDisplay != null)
                              .map((element) => JRoundedImage(
                                    width: 90,
                                    height: 90,
                                    padding: JSizes.sm,
                                    imageType: ImageType.memory,
                                    memoryImage: element.localImageToDisplay,
                                    backgroundColor: JColors.primaryBackground,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: JSizes.spaceBtwItems),
                        JDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.uploadImagesConfrimation(),
                                    child: const Text('Upload')),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                const SizedBox(height: JSizes.spaceBtwItems),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
