import 'dart:io';
import 'dart:typed_data';

import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class JCircularImage extends StatelessWidget {
  const JCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = JSizes.sm,
    this.file,
    this.imageType = ImageType.asset,
    this.memoryImage,
  });

  final BoxFit? fit;
  final ImageType imageType;
  final Uint8List? memoryImage;
  final File? file;
  final String? image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
        borderRadius: BorderRadius.circular(width >= height ? width : height),
      ),
      child: _buildImageWidget(),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(100),
      //   child: Center(
      //     child: isNetworkImage
      //         ? Image.network(
      //             image,
      //             fit: fit,
      //             color: overlayColor,
      //             errorBuilder: (context, error, stackTrace) {
      //               return const Icon(Icons
      //                   .error); // Display error icon if image fails to load
      //             },
      //           )
      //         : Image.asset(
      //             image,
      //             fit: fit,
      //             color: overlayColor,
      //           ),
      //   ),
      // ),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;
    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(width >= height ? width : height),
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if (image != null) {
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const JShimmerEffect(width: 55, height: 55),
      );
    } else {
      return Container();
    }
  }

  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
        fit: fit,
        color: overlayColor,
        image: MemoryImage(memoryImage!),
      );
    } else {
      return Container();
    }
  }

  Widget _buildFileImage() {
    if (file != null) {
      return Image(
        fit: fit,
        image: FileImage(file!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null) {
      return Image(
        fit: fit,
        image: AssetImage(image!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }
}
