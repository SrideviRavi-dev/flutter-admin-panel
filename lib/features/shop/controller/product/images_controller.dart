// ignore_for_file: unnecessary_null_comparison

import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  // Get all Images from Product variations
  List<String> getAllProductImages(ProductsModel product) {
    Set<String> images = {};

    images.add(product.thumbnail);

    selectedProductImage.value = product.thumbnail;

    if(product.imageUrls != null){
      images.addAll(product.imageUrls!);
    }

    if(product.productVariations != null || product.productVariations!.isNotEmpty){
      images.addAll(product.productVariations!.map((variations) => variations.image.value));
    }

    return images.toList();
  }

  void showEnlargeImage(String image){
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
       child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Padding(
          padding: const EdgeInsets.symmetric(vertical: JSizes.defaultSpace * 2,horizontal: JSizes.defaultSpace),
          child: CachedNetworkImage(imageUrl: image),
          ),
          const SizedBox( height:  JSizes.spaceBtwSections),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              child: OutlinedButton(onPressed: ()=> Get.back(), child: const Text('Close')),
            ),
          )
        ],
       ) ,
      )
    );
  }
}