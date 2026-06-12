// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/product_repository/product_repository.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  final imagesController = Get.put(ProductImageController());
  final attributesController = Get.put(ProductAttributeController());
  final variationController = Get.put(ProductVariationController());

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();

  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];
  RxBool thumnailUploader = true.obs;
  RxBool additionalImagesUploader = true.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  void initProductData(ProductsModel product) {
    try {
      isLoading.value = true;
      title.text = product.title;
      description.text = product.description?.toString() ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      if (product.imageUrls != null) {
        imagesController.additionalProdutImagesUrls.assignAll(product.imageUrls ?? []);
      }
      if (product.thumbnail != null && product.thumbnail!.isNotEmpty) {
        imagesController.seletedThumbnailImageUrl.value = product.thumbnail!;
      }
      attributesController.productAttributes.assignAll(product.productAttributes ?? []);
      variationController.productVariations.assignAll(product.productVariations ?? []);
      variationController.initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false;
      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    try {
      selectedCategoriesLoader.value = true;

      final productCategories = await productRepository.getProductsCategories(productId);
      final categoryIds = productCategories.map((e) => e.categoryId).toList();

      final categoriesController = Get.put(CategoryController());
      if (categoriesController.allItems.isEmpty) {
        await categoriesController.fetchItems();
      }

      final matchedCategories = categoriesController.allItems
          .where((element) => categoryIds.contains(element.id))
          .toList();

      selectedCategories.assignAll(matchedCategories);
      alreadyAddedCategories.assignAll(matchedCategories);
      selectedCategoriesLoader.value = false;

      return matchedCategories;
    } catch (e) {
      selectedCategoriesLoader.value = false;
      return [];
    }
  }

  Future<void> editProduct(ProductsModel product) async {
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
        final variationCheckFailed = ProductVariationController.instance.productVariations.any(
          (element) =>
              element.price.isNaN ||
              element.price < 0 ||
              element.salePrice.isNaN ||
              element.salePrice < 0 ||
              element.stock.isNaN ||
              element.stock < 0,
        );

        if (variationCheckFailed)
          throw 'Variation data is not accurate. Please recheck variations';
      }

      final imagesController = ProductImageController.instance;
      if (imagesController.seletedThumbnailImageUrl.value == null ||
          imagesController.seletedThumbnailImageUrl.value!.isEmpty) {
        throw 'Select Product Thumbnail Image';
      }

      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.clear();
      }

      product.title = title.text.trim();
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.thumbnail = imagesController.seletedThumbnailImageUrl.value ?? '';
      product.productVariations = variations;
      product.productAttributes = ProductAttributeController.instance.productAttributes;
      product.imageUrls = imagesController.additionalProdutImagesUrls;
      product.description = [description.text.trim()];
      product.date = DateTime.now();

      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);

      if (selectedCategories.isNotEmpty) {
        await ProductRepository.instance.updateProductSpecificValue(product.id, {
          'categoryId': selectedCategories.first.id,
        });
      }

      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        final existingProductCategories =
            await ProductRepository.instance.getProductsCategories(product.id);
        final existingCategoryIds =
            existingProductCategories.map((e) => e.categoryId).toList();

        final List<Future<void>> removeFutures = existingCategoryIds
            .where((id) => !selectedCategories.any((cat) => cat.id == id))
            .map<Future<void>>((id) => ProductRepository.instance.removerProductCategory(product.id, id))
            .toList();

        final List<Future<void>> addFutures = selectedCategories
            .where((cat) => !existingCategoryIds.contains(cat.id))
            .map<Future<void>>((cat) {
              final productCategory = ProductCategoryModel(
                productId: product.id,
                categoryId: cat.id,
              );
              return ProductRepository.instance.createProductCategory(productCategory);
            })
            .toList();

        await Future.wait([...removeFutures, ...addFutures]);

        final allCategoryIds = {
          ...existingCategoryIds,
          ...selectedCategories.map((e) => e.id),
        };
        await ProductController.instance.refreshCategoryProducts(allCategoryIds);
      }

      ProductController.instance.updateItemFromLists(product);

      JFullScreenLoader.stopLoading();
      showCompletionDialog();
    } catch (e, stackTrace) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      if (kDebugMode) {
        print('❌ Error in editProduct: \$e');
        print(stackTrace);
      }
    }
  }

  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Congratulations'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go to Products')),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            JImages.logo,
            height: 200,
            width: 200,
          ),
          const SizedBox(height: JSizes.spaceBtwItems),
          Text('Conguratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwItems),
          const Text('Your Prouct has been Created'),
        ],
      ),
    ));
  }
}