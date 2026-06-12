import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/product/edit_product_controller.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/controller/product/variation_controller.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/features/shop/models/product_variation_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductVariations extends StatelessWidget {
  
  const ProductVariations({super.key, required this.products});
final ProductsModel products;
  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;
    return Obx(
      ()=> EditProductController.instance.productType.value == ProductType.variable
      ? JRoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product Variations',
                    style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                    onPressed: () => variationController.removeVariations(context),
                     child: const Text('Remove Variations')),
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwItems),
            if(variationController.productVariations.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              itemCount: variationController.productVariations.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: JSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final variation = variationController.productVariations[index];
                return _buildVariationTile(context,index,variation,variationController);
              },
            ) else
            _buildVariationMessage(),
          ],
        ),
      ): const SizedBox.shrink()
    );
  }

  Widget _buildVariationTile(
    BuildContext context,int index, ProductVariationModel variation,ProductVariationController  variationController

  ) {
    return ExpansionTile(
      backgroundColor: JColors.lightGrey,
      collapsedBackgroundColor: JColors.lightGrey,
      childrenPadding: const EdgeInsets.all(JSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JSizes.borderRadiusLg)),
      title:  Text(variation.attributeValues.entries.map((entry)=>'${entry.key}: ${entry.value}').join(',')),
      children: [
        Obx(() => JImageUploader(
              right: 0,
              left: null,
              imageType:variation.image.value.isNotEmpty ? ImageType.network: ImageType.asset,
              image:variation.image.value.isNotEmpty?variation.image.value: JImages.photo,
              onIconButtonPressed: () => ProductImageController.instance.selectVariationImage(variation),
            )),
        const SizedBox(height: JSizes.spaceBtwInputFields),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock,only numbers are allowed'),
              ),
            ),
            const SizedBox(width: JSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                onChanged: (value) => variation.salePrice = double.parse(value),
                decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with up-to 2 decimals'),
                    controller: variationController.priceControllersList[index][variation],
              ),
            ),
            const SizedBox(width: JSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.salePrice =double.parse(value) ,
                controller: variationController.salePriceControllersList[index][variation],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
                decoration: const InputDecoration(
                    labelText: 'Discounted price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),
          ],
        ),
        const SizedBox(height: JSizes.spaceBtwInputFields),
        TextFormField(
          onChanged: (value) => variation.description = value,
          controller: variationController.descriptionControllerList[index][variation],
          decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Add description of this variation....'),
        ),
        const SizedBox(height: JSizes.spaceBtwSections),
      ],
    );
  }

  Widget _buildVariationMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JRoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: JImages.logo,
            ),
          ],
        ),
        SizedBox(height: JSizes.spaceBtwItems),
        Text('There are no Variations added for this product'),
      ],
    );
  }
}
