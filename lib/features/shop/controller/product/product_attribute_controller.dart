import 'package:admin/features/shop/controller/product/variation_controller.dart';
import 'package:admin/features/shop/models/product_attribute_model.dart';
import 'package:admin/utils/popups/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributeController extends GetxController {
  static ProductAttributeController get instance => Get.find();

  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  void addNewAttribute() {
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));

    attributeName.text = '';
    attributes.text = '';
  }

  void removeAttribute(int index, BuildContext context) {
    JDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        ProductVariationController.instance.productVariations.value = [];
      },
    );
  }

  void restProductAttributes() {
    productAttributes.clear();
  }
}
