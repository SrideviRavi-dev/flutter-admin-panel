import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/additional_images.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/attributes_widgets.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/bottom_navigation.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/categories_widget.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/product_type_widget.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/stock_pricing_widget.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/thumbnail_widget.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/title_description.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/variations_widget.dart';
import 'package:admin/features/shop/screens/product/edit_product/widgets/visibility_widget.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductMobilScreen extends StatelessWidget {
  const EditProductMobilScreen({super.key, required this.product});
 final ProductsModel product;
 @override
  Widget build(BuildContext context) {
     final controller = Get.put(ProductImageController());
    return Scaffold(
       bottomNavigationBar:  ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [JRoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: JDeviceUtils.isDesktopScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         ProductTitleAndDescription(product: product),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        JRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Stock & Pricing',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: JSizes.spaceBtwItems),
                               ProductTypeWidget(product: product),
                              const SizedBox(
                                  height: JSizes.spaceBtwInputFields),
                               ProductStockAndPricing(product: product),
                              const SizedBox(height: JSizes.spaceBtwSections),
                               ProductAttributes(products: product),
                              const SizedBox(height: JSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),
                         ProductVariations(products: product),
                      ],
                    ),
                  ),
                  const SizedBox(height: JSizes.defaultSpace),
                  Expanded(
                      child: Column(
                    children: [
                       ProductThumbnailImage(product:product),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      JRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All Product Images',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: JSizes.spaceBtwSections),
                            ProductAdditionalImages(
                               additionalProductImagesURLs:
                                 controller.additionalProdutImagesUrls,
                              onTapToAddImages: ()  => controller.selectMultipleProductImage(),
                              onTapToRemoveImages: (index) => controller.removeImage(index),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: JSizes.spaceBtwSections),
                       ProductCategories(product: product),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      const ProductVisibilityWidget(),
                      const SizedBox(height: JSizes.spaceBtwSections),
                    ],
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
