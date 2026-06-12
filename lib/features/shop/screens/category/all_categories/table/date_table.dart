import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/screens/category/all_categories/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTable extends StatelessWidget {
  const CategoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Obx(
        () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());
        return JPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          columns: [
            DataColumn2(
                label: Text('Category'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: Text('Parent Category'),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(label: Text('Featured')),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: CategoryRows(),
        );
      }),
    );
  }
}
