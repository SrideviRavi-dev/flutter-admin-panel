import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/banner/banner_controller.dart';
import 'package:admin/features/shop/screens/banner/all_banner/table/table.source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString()); 
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: JPaginatedDataTable(
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: const [
            DataColumn2(label: Text('Banners')),
            DataColumn2(label: Text('Redirect Screen')),
            DataColumn2(label: Text('Active')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: BannersRow(),
        ),
      );
    });
  }
}
