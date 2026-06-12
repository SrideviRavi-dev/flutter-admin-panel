import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key, required this.product});
final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    final ProductImageController controller = Get.put(ProductImageController());
    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Thumbnail',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwItems),
          JRoundedContainer(
            height: 300,
            backgroundColor: JColors.primaryBackground,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(
                        ()=> JRoundedImage(
                          width: 220,
                          height: 220,
                          image:controller.seletedThumbnailImageUrl.value ??  JImages.photo,
                          imageType:controller.seletedThumbnailImageUrl.value == null ? ImageType.asset : ImageType.network,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    width: 200,
                    child: OutlinedButton(
                        onPressed: () => controller.selectThumbnailImage(), 
                        child: const Text('Add Thumbnail'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
