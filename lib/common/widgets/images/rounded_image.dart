import 'dart:io';
import 'dart:typed_data';

import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class JRoundedImage extends StatelessWidget {
  const JRoundedImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.image,
    this.memoryImage,
    this.file,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = JColors.light,
    this.fit = BoxFit.cover,
    this.padding = JSizes.sm,
    this.isNetworkImage = false,
    this.onPressed,
    this.margin,
    this.borderRadius = JSizes.md, 
    required this.imageType, this.overlayColor,
  });
  final double width, height;
  final Color? overlayColor;
  final double? margin;
  final String? image;
  final File? file;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final ImageType imageType;
  final BoxFit? fit;
  final double padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Uint8List? memoryImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!): null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        
      ),
      
     child: _buildImageWidget(),
         );
  }
  Widget _buildImageWidget(){
        Widget imageWidget;

        switch (imageType){
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
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
       child: imageWidget,
        );
      }
    Widget _buildNetworkImage(){
      if(image != null){
        return CachedNetworkImage(
          fit: fit,
          color: overlayColor,
          imageUrl: image!,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          progressIndicatorBuilder: (context, url, downloadProgress) => JShimmerEffect(width: width, height: height) ,
          );
      }else{
        return Container();
      }
    }

    Widget _buildMemoryImage(){
      if(memoryImage != null){
        return Image( fit: fit, color: overlayColor, image:  MemoryImage(memoryImage!), );
      }else {
        return Container();
      }
    }

    Widget _buildFileImage(){
      if(file != null){
        return Image(fit: fit,image: FileImage(file!),color: overlayColor,);
      }else{
        return Container();
      }
    }

    Widget _buildAssetImage(){
      if(image != null){
        return Image(fit: fit,image:AssetImage(image!),color: overlayColor, );
      }else{
        return Container();
      }
    }

}
 
