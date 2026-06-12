import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/product/product_controller.dart';
import 'package:admin/features/shop/screens/category/all_categories/widgets/table_action_icon_button.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsRow extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(JRoutes.editProduct, arguments: product),
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              JRoundedImage(
                width: 50,
                height: 50,
                padding: JSizes.xs,
                image: (product.imageUrls != null &&
                        product.imageUrls!.isNotEmpty)
                    ? product.imageUrls!.first
                    : (product.thumbnail.isNotEmpty ? product.thumbnail : null),
                imageType: ImageType.network,
                borderRadius: JSizes.borderRadiusMd,
                backgroundColor: JColors.primaryBackground,
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Flexible(
                  child: Text(product.title,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge!
                          .apply(color: JColors.primary))),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(Text(controller.getProductSoldQuantity(product))),
        DataCell(Text('₹${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(
          JTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(JRoutes.editProduct, arguments: product),
            onDeletePressed: () => controller.confirmAndDeleteItem(product),
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
