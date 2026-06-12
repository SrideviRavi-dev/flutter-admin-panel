import 'package:admin/features/shop/controller/product/product_attribute_controller.dart';
import 'package:admin/features/shop/models/product_variation_model.dart';
import 'package:admin/utils/popups/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllerList = [];

  final attributesController = Get.put(ProductAttributeController());

  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllerList.clear();
  }

  void removeVariations(BuildContext context) {
    JDialogs.defaultDialog(
      context: context,
      title: 'Remove Variations',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  void generateVariationsConfirmation(BuildContext context) {
    JDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      content:
          'Once the variation are created, you cannot add more attributes. In order to add more variations, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFormAttribute(),
    );
  }

  void generateVariationsFormAttribute() {
    Get.back();

    final List<ProductVariationModel> variations = [];

    if (attributesController.productAttributes.isNotEmpty) {
      final List<List<String>> attributeCombinations = getCombinations(
          attributesController.productAttributes
              .map((attr) => attr.values ?? <String>[])
              .toList());

      for (final comination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributesController.productAttributes
                .map((attr) => attr.name ?? ''),
            comination);

        final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(), attributeValues: attributeValues);
        variations.add(variation);

        final Map<ProductVariationModel, TextEditingController>
            stockControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            priceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllerList.add(descriptionControllers);
      }
    }
    productVariations.assignAll(variations);
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];

    combine(lists, 0, <String>[], result);
    return result;
  }

  void combine(List<List<String>> lists, int index, List<String> current,
      List<List<String>> result) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }
    for (final item in lists[index]) {
      final List<String> updated = List.from(current)..add(item);

      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllerList.clear();
  }

  // void onAttributeSelected(
  //     ProductsModel product, attributeName, attributeValue) {
  //   final selectedAttributes =
  //       Map<String, dynamic>.from(this.selectedAttributes);
  //   selectedAttributes[attributeName] = attributeValue;
  //   this.selectedAttributes[attributeName] = attributeValue;

  //   final selectedVariation = product.productVariations!.firstWhere(
  //     (variation) =>
  //         _isSameAttributeValues(variation.attributeValues, selectedAttributes),
  //     orElse: () => ProductVariationModel.empty(),
  //   );
  //   if (selectedVariation.image.isNotEmpty) {
  //     ImagesController.instance.selectedProductImage.value =
  //         selectedVariation.image.value;
  //   }

  //   if (selectedVariation.id.isNotEmpty) {
  //     final cartController = CartController.instance;
  //     cartController.productQuantityInCart.value = cartController
  //         .getVariationQuantityInCart(product.id, selectedVariation.id);
  //   }

  //   this.selectedVariation.value = selectedVariation;

  //   getProductVariationStockStatus();
  // }

  // bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
  //     Map<String, dynamic> selectedAttributes) {
  //   if (variationAttributes.length != selectedAttributes.length) return false;

  //   for (final key in variationAttributes.keys) {
  //     if (variationAttributes[key] != selectedAttributes[key]) return false;
  //   }
  //   return true;
  // }

  // Set<String?> getAttributesAvailablilityInVariation(
  //     List<ProductVariationModel> variations, String attributeName) {
  //   final availableVariationAttributeValues = variations
  //       .where((variation) =>
  //           variation.attributeValues[attributeName] != null &&
  //           variation.attributeValues[attributeName]!.isNotEmpty &&
  //           variation.stock > 0)
  //       .map((variation) => variation.attributeValues[attributeName])
  //       .toSet();

  //   return availableVariationAttributeValues;
  // }

  // String getVariationPrice() {
  //   return (selectedVariation.value.salePrice > 0
  //           ? selectedVariation.value.salePrice
  //           : selectedVariation.value.price)
  //       .toString();
  // }

  // void getProductVariationStockStatus() {
  //   variationStockStatus.value =
  //       selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  // }
}
