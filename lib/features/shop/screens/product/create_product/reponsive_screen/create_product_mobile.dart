import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/additional_images.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/attributes_widgets.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/bottom_navigation_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/categories_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/product_type_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/stock_pricing_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/thumbnail_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/title_description.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/variations_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/visibility_widget.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final controller = Get.put(ProductImageController());
    return Scaffold(
       bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [JRoutes.products, 'Create Product'],
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
                        const ProductTitleAndDescription(),
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
                              const ProductTypeWidget(),
                              const SizedBox(
                                  height: JSizes.spaceBtwInputFields),
                              const ProductStockAndPricing(),
                              const SizedBox(height: JSizes.spaceBtwSections),
                              const ProductAttributes(),
                              const SizedBox(height: JSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(height: JSizes.defaultSpace),
                  Expanded(
                      child: Column(
                    children: [
                      const ProductThumbnailImage(),
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
                              onTapToAddImages: () => controller.selectMultipleProductImage(),
                              onTapToRemoveImages: (index) => controller.removeImage(index),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      const ProductCategories(),
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
