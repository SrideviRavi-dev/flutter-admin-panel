import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/features/shop/screens/order/all_orders/table/table_source.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: JPaginatedDataTable(
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          minWidth: 700,
          dataRowHeight: kMinInteractiveDimension,
          columns: [
            DataColumn2(label: Text('Order ID')),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Items')),
            DataColumn2(
                label: Text('Status'),
                fixedWidth: JDeviceUtils.isMobileScreen(context) ? 100 : null),
            DataColumn2(label: Text('Amount')),
            const DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: OrderRows(),
        ),
      );
    });
  }
} 

