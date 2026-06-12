// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/product_repository/product_repository.dart';
import 'package:admin/features/shop/controller/product/product_attribute_controller.dart';
import 'package:admin/features/shop/controller/product/product_controller.dart';
import 'package:admin/features/shop/controller/product/product_image_controller.dart';
import 'package:admin/features/shop/controller/product/variation_controller.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:admin/features/shop/models/product_category_model.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  final RxList<String> selectedSizes = <String>[].obs;

  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  RxBool thumnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Method to create the product and fetch categoryId
  Future<void> createProduct() async {
    try {
      JFullScreenLoader.popUpCircular();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        JFullScreenLoader.stopLoading();
        return;
      }

      if (!titleDescriptionFormKey.currentState!.validate()) {
        JFullScreenLoader.stopLoading();
        return;
      }

      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        JFullScreenLoader.stopLoading();
        return;
      }

      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the product type Variation. Create some variations or change product type';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFailed)
          throw 'Variation data is not accurate. Please recheck variations';
      }

      thumnailUploader.value = true;
      final imagesController = ProductImageController.instance;
      if (imagesController.seletedThumbnailImageUrl.value == null)
        throw 'Select Product Thumbnail Image';

      additionalImagesUploader.value = true;

      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Step 1: Fetch product-category relationship
      String? categoryId = '';
      if (selectedCategories.isNotEmpty) {
        categoryId =
            selectedCategories.first.id; // Assuming you select one category
      }

      // Step 2: Create product record
      final newRecord = ProductsModel(
        id: '',
        title: title.text.trim(),
        price: double.tryParse(price.text.trim()) ?? 0,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        discountPercentage: discountPercentageController.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        thumbnail: imagesController.seletedThumbnailImageUrl.value ?? '',
        productVariations: variations,
        sizes: selectedSizes.toList(),
        productAttributes:
            ProductAttributeController.instance.productAttributes,
        imageUrls: imagesController.additionalProdutImagesUrls,
        description: [description.text.trim()],
        date: DateTime.now(),
        categoryId: categoryId,
      );

      // Step 3: Upload product data to Firestore
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
            productId: newRecord.id,
            categoryId: category.id,
          );
          await ProductRepository.instance
              .createProductCategory(productCategory);
        }
      }

      ProductController.instance.addItemToLists(newRecord);

      JFullScreenLoader.stopLoading();

      showCompletionDialog();
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Method to reset the form values
  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributeController.instance.restProductAttributes();

    thumnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  // Method to show the success dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go to Products'),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(JImages.logo, height: 200, width: 200),
            const SizedBox(height: JSizes.spaceBtwItems),
            Text('Congratulations',
                style: Theme.of(Get.context!).textTheme.headlineSmall),
            const SizedBox(height: JSizes.spaceBtwItems),
            const Text('Your Product has been Created'),
          ],
        ),
      ),
    );
  }
}
