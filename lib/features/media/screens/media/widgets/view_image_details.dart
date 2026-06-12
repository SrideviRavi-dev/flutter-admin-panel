import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  final ImageModel image;

  const ImagePopup({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(JSizes.borderRadiusLg)),
        child: JRoundedContainer(
          width: JDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    JRoundedContainer(
                      backgroundColor: JColors.primaryBackground,
                      child: JRoundedImage(
                          image: image.url,
                          applyImageRadius: true,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: JDeviceUtils.isDesktopScreen(context)
                              ? MediaQuery.of(context).size.width * 0.4
                              : double.infinity,
                          imageType: ImageType.network),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Iconsax.close_circle)))
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Name:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(image.filename,
                          style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text('Image URL:',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                    flex: 2,
                    child: Text(image.url,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Clipboard copying logic
                        FlutterClipboard.copy(image.url).then((value) =>
                            JLoaders.customToast(message: 'URL Copied'));
                      },
                      child: const Text('Copy URL'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: ()=>  MediaController.instance.removeCloudImageConfirmation(image),
                      child: const Text(
                        'Delete Image',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
