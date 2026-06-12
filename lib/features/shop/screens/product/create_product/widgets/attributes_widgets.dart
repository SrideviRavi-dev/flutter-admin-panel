import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/features/shop/controller/product/product_attribute_controller.dart';
import 'package:admin/features/shop/controller/product/variation_controller.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributeController());
    final variationController = Get.put(ProductVariationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? const Column(
                  children: [
                    Divider(
                      color: JColors.primaryBackground,
                    ),
                    SizedBox(
                      height: JSizes.spaceBtwItems,
                    )
                  ],
                )
              : const SizedBox.shrink();
        }),
        Text('Add Product Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: JSizes.spaceBtwItems,
        ),
        Form(
          key: attributeController.attributesFormKey,
          child: JDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildAttributeName(attributeController),
                    ),
                    const SizedBox(width: JSizes.spaceBtwItems),
                    Expanded(
                      flex: 2,
                      child: _buildAttributeTextField(attributeController),
                    ),
                    const SizedBox(width: JSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(width: JSizes.spaceBtwItems),
                    _buildAttributeTextField(attributeController),
                    const SizedBox(width: JSizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                ),
        ),
        // Column(
        //     children: [
        //       buildAttributesList(context),
        //       buildEmptyAttributes(),
        //     ],
        //   ),
        const SizedBox(height: JSizes.spaceBtwSections),
        Text('All Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: JSizes.spaceBtwItems),
        JRoundedContainer(
          backgroundColor: JColors.primaryBackground,
          child:Obx(
            () => attributeController.productAttributes.isNotEmpty
            ? ListView.separated(
              shrinkWrap: true,
               itemCount: attributeController.productAttributes.length,
               separatorBuilder: (_, __) => const SizedBox(height: JSizes.spaceBtwItems), 
              itemBuilder:(_,index){
                return Container(
                  decoration: BoxDecoration(
                    color: JColors.white,
                    borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
                  ),
                  child: ListTile(
                    title: Text(attributeController.productAttributes[index].name ?? ''),
                    subtitle: Text(attributeController.productAttributes[index].values!.map((e)=> e.trim()).toString()),
                    trailing: IconButton(onPressed: ()=>attributeController.removeAttribute(index, context), 
                    icon: const Icon(Iconsax.trash,color: JColors.error),),
                  ),
                );
              } , 
             
             
              )
              :const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      JRoundedImage(
                        width: 150,
                        height: 80,
                        imageType: ImageType.asset,
                        image: JImages.photo,
                      ),
                    ],
                  ),
                  SizedBox(height: JSizes.spaceBtwItems),
                  Text('There are no attributes added for this product'),
                ],
              )
          ),
          
           
        ),
        const SizedBox(height: JSizes.spaceBtwSections),
        Obx(
          ()=> productController.productType.value == ProductType.variable && variationController.productVariations.isEmpty
          ? Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                icon: const Icon(Iconsax.activity),
                label: const Text('Generate Variations'),
                onPressed: () => variationController.generateVariationsConfirmation(context),
              ),
            ),
          ):const SizedBox.shrink(),
        )
      ],
    );
  }

  Column buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: JImages.logo,
            ),
          ],
        ),
        SizedBox(height: JSizes.spaceBtwItems),
        Text('There are no attributes added for this product'),
      ],
    );
  }

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: JSizes.spaceBtwItems),
      itemCount: 3,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: JColors.white,
            borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Orange, Pink'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Iconsax.trash, color: JColors.error),
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildAddAttributeButton(ProductAttributeController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: JColors.black,
          backgroundColor: JColors.secondary,
          side: const BorderSide(color: JColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  TextFormField _buildAttributeName(ProductAttributeController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          JValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors Sizes, Material'),
    );
  }

  SizedBox _buildAttributeTextField(ProductAttributeController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        controller: controller.attributes,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            JValidator.validateEmptyText('Attribute Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText:
              'Add attribute separated by | example: Green | Blue | Yellow ',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
