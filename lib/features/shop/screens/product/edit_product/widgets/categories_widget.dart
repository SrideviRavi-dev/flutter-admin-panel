import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/controller/product/edit_product_controller.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/helper/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final productcontroller = EditProductController.instance;

    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwItems),
          FutureBuilder(
            future: productcontroller.loadSelectedCategories(product.id),
            builder: (context, snapshot) {
              final widget = JCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if (widget != null) return widget;

              final allCategories = CategoryController.instance.allItems;
              final selected = snapshot.data ?? [];

              return Obx(() => MultiSelectDialogField<CategoryModel>(
                    buttonText: const Text('Select Categories'),
                    title: const Text('Categories'),
                    items: allCategories
                        .map((category) => MultiSelectItem<CategoryModel>(category, category.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    initialValue: productcontroller.selectedCategories.isEmpty
                        ? selected
                        : productcontroller.selectedCategories,
                    onConfirm: (values) {
                      productcontroller.selectedCategories.assignAll(
                        values.map((e) => e as CategoryModel).toList(),
                      );
                    },
                    searchable: true,
                    selectedColor: Colors.lightBlue.withOpacity(0.5), // 🌟 Light Blue Color
                    chipDisplay: MultiSelectChipDisplay(
                      items: productcontroller.selectedCategories
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
                      onTap: (value) =>
                          productcontroller.selectedCategories.remove(value),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
