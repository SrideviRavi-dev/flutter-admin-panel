import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/controller/product/edit_product_controller.dart';
import 'package:admin/features/shop/screens/product/edit_product/responsive_screen/edit_product_desktop.dart';
import 'package:admin/features/shop/screens/product/edit_product/responsive_screen/edit_product_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductData(product);
  return  JSiteTemplate(
      desktop: EditProductDesktopScreen(product: product),
      tablet: EditProductMobilScreen(product: product),
    );
  }
}