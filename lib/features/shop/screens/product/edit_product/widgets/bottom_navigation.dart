import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/edit_product_controller.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key, required this.product});
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    return  JRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         OutlinedButton(onPressed: ()=>Get.back(),
          child: const Text('Discard')),
          const SizedBox(width: JSizes.spaceBtwItems / 2),

          SizedBox(width: 160,child: ElevatedButton(
            onPressed: ()=> EditProductController.instance.editProduct(product),
           child: const Text('Save Changes')),)
        ],
      ),
    );
  }
}