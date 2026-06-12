import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  JRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         OutlinedButton(onPressed: (){},
          child: const Text('Discard')),
          const SizedBox(width: JSizes.spaceBtwItems / 2),

          SizedBox(width: 160,child: ElevatedButton(
            onPressed: ()=> CreateProductController.instance.createProduct(),
           child: const Text('Save Changes')),)
        ],
      ),
    );
  }
}