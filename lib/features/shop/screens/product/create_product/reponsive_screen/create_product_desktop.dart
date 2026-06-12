import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/additional_images.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/attributes_widgets.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/bottom_navigation_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/categories_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/discount_percentage_widget.dart';
import 'package:admin/features/shop/screens/product/create_product/widgets/product_size_widget.dart';
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

class CreateProductDesktopScreen extends StatelessWidget {
  const CreateProductDesktopScreen({super.key});

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
                              const DiscountPercentageWidget(),
                              const SizedBox(height: JSizes.spaceBtwItems),
                              SizeSelectorWidget(
                                availableSizes: [
                                 'Free', 'XXS','XS','S','M','L','XL','2XL','3XL','4XL','5XL','6XL','28','30','32','34','38','40','42','5','6','7','8','9','10','4-5Y','6-7Y','8-9Y','9-10Y','11-12Y','13-14Y','15-16Y','32B','34B', '36B','38B', '42B','34C','36C','38C','42C','32D', '34D', '36D', '38D','32DD','48DD',
                                   ], // or your dynamic size list
                                selectedSizes: CreateProductController
                                    .instance.selectedSizes,
                                onSelectionChanged: (newSizes) {
                                  CreateProductController.instance.selectedSizes
                                      .assignAll(newSizes);
                                },
                              ),
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
                              onTapToAddImages: () =>
                                  controller.selectMultipleProductImage(),
                              onTapToRemoveImages: (index) =>
                                  controller.removeImage(index),
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
