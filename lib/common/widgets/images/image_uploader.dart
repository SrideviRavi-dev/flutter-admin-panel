// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:admin/common/widgets/container/circular_container.dart';
import 'package:admin/common/widgets/icon/circular_icon.dart';
import 'package:admin/common/widgets/images/circular_images.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class JImageUploader extends StatelessWidget {
  const JImageUploader({
    super.key,
    this.circular = false,
    this.image,
    required this.imageType,
    this.width = 100,
    this.height = 100,
    this.memoryImage,
    this.icon = Iconsax.edit_2,
    this.top,
    this.bottom = 0,
    this.right,
    this.left = 0,
    this.onIconButtonPressed,
    this.loading = false,
  });
  final bool loading;
  final bool circular;
  final String? image;
  final ImageType imageType;
  final double width;
  final double height;
  final Uint8List? memoryImage;
  final IconData icon;
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final void Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        circular
            ? JCircularImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: JColors.primaryBackground,
              )
            : JRoundedImage(
                image: image,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: JColors.primaryBackground,
              ),
        Positioned(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
            child: loading
                ? const JCircularContainer(
                    width: JSizes.xl,
                    height: JSizes.xl,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: JColors.primary,
                      color: Colors.white,
                    ),
                  )
                : JCircularIcon(
                    icon: icon,
                    size: JSizes.md,
                    color: Colors.white,
                    onPressed: onIconButtonPressed,
                    backgroundColor: JColors.primary.withOpacity(0.9),
                  )),
      ],
    );
  }
}
