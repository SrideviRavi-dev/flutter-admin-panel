import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/banner/banner_controller.dart';
import 'package:admin/features/shop/screens/category/all_categories/widgets/table_action_icon_button.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRow extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(JRoutes.editBanner, arguments: banner),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
            JRoundedImage(
              width: 180,
              height: 100,
              padding: JSizes.sm,
              image: banner.imageUrl,
              imageType: ImageType.network,
              borderRadius: JSizes.borderRadiusMd,
              backgroundColor: JColors.primaryBackground,
            ),
          ),
          DataCell(Text(controller.formatRoute(banner.targetScreen))),
          DataCell(banner.active
              ? const Icon(Iconsax.eye, color: JColors.primary)
              : const Icon(Iconsax.eye_slash)),
          DataCell(JTableActionButtons(
            onEditPressed: () => Get.toNamed(
              JRoutes.editBanner,
              arguments: banner,
            ),
            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected)=>selected).length;
}
