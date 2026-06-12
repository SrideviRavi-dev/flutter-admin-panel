import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/customer/customer_detail_controller.dart';
import 'package:admin/features/shop/screens/customer/customer_details/table/table_source.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(() {
      Text(controller.fillteredCustomerOrders.length.toString());
      Text(controller.selectedRows.length.toString());
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: JPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: Text('Order ID'),onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            DataColumn2(label: Text('Date')),
            DataColumn2(label: Text('Items')),
            DataColumn2(
                label: Text('Status'),
                fixedWidth: JDeviceUtils.isMobileScreen(context) ? 100 : null),
            DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrderRows(),
        ),
      );
    });
  }
}
