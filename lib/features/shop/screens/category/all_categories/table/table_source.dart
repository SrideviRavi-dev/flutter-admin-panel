import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/screens/category/all_categories/widgets/table_action_icon_button.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;

  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems
        .firstWhereOrNull((item) => item.id == category.parentId);
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: JRoundedImage(
                  padding: JSizes.sm,
                  image: category.image,
                  imageType: ImageType.network,
                  borderRadius: JSizes.borderRadiusMd,
                  backgroundColor: JColors.primaryBackground,
                ),
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Expanded(
                  child: Text(
                category.name,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge!
                    .apply(color: JColors.primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
        DataCell(Text(parentCategory != null ? parentCategory.name : '')),
        DataCell(category.isFeatured
            ? const Icon(Iconsax.heart5, color: JColors.primary)
            : const Icon(Iconsax.heart)),
        DataCell(
            Text(category.createdAt == null ? '' : category.formattedDate)),
        DataCell(JTableActionButtons(
          onEditPressed: () {
            // Debugging: Print category details before navigating
            print('Navigating to Edit Category: ${category.name}');
            Get.toNamed(JRoutes.editCategory, arguments: category);
          },
          onDeletePressed: () => controller.confirmAndDeleteItem(category),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
