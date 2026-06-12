import 'package:admin/common/widgets/data_table/pagenavigationdata_table.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/features/shop/screens/dashboard/table/table_source.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(
   (){
    Text (controller.filteredItems.length.toString());
    Text (controller.selectedRows.length.toString());
    return  SizedBox(
        height: 350,
        child: JPaginatedDataTable(
              minWidth: 700,
              tableHeight: 500,
              dataRowHeight: JSizes.xl * 1.2,
              sortAscending: controller.sortAscending.value,
              sortColumnIndex: controller.sortColumnIndex.value,
             columns: [
              DataColumn2(label: Text('Order Id'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
              DataColumn2(label: Text('Date')),
              DataColumn2(label: Text('Items')),
              DataColumn2(label: Text('Status'), fixedWidth: JDeviceUtils.isMobileScreen(context) ? 120 : null),
              DataColumn2(label: Text('Account')),
        
             ],
             source:DashboardOrderRows() ,
        ),
      );
   } 
    );
  }
}