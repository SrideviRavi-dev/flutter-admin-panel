import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.put(CategoryController());
    if(categoriesController.allItems.isEmpty){
      categoriesController.fetchItems();
    }

    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories',style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwItems),
          Obx(
            ()=>categoriesController.isLoading.value
          ?const JShimmerEffect(width: double.infinity, height: 50)
          : MultiSelectDialogField(
              buttonText:const Text('Select Categories'),
              title: const Text ('Categories'),
              items: categoriesController.allItems.map((category)=> MultiSelectItem(category, category.name)).toList(), 
              listType: MultiSelectListType.CHIP,
              onConfirm: (values){
                CreateProductController.instance.selectedCategories.assignAll(values);
              },
              ),
          )
        ],
      ),
    );
  }
}