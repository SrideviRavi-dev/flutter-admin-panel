import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/product/product_controller.dart';
import 'package:admin/features/shop/screens/product/all_product/table/table_source.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: JPaginatedDataTable(
          minWidth: 1000,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
              label: const Text('Product'),
              fixedWidth: !JDeviceUtils.isDesktopScreen(context) ? 300 : 400,
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text('Stock'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByStock(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text('Sold'),
              onSort: (columnIndex, ascending) =>
                  controller.sortBySoldItems(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text('Price'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByPrice(columnIndex, ascending),
            ),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: ProductsRow(),
        ),
      );
    });
  }
}
