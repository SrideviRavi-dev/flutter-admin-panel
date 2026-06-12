// ignore_for_file: deprecated_member_use
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardOrderRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(
      onTap: ()=> Get.toNamed(JRoutes.orderDetails, arguments: order),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .apply(color: JColors.primary),
      )),
      DataCell(Text(order.formattedOrderDate)),
       DataCell(Text('${order.items.length} items')),
      DataCell(
        JRoundedContainer(
          radius: JSizes.cardRadiusSm,
          padding: const EdgeInsets.symmetric(
              vertical: JSizes.xs, horizontal: JSizes.md),
          backgroundColor: JHelperFunction.getOrderStatusColor(order.status)
              .withOpacity(0.1),
          child: Text(
            order.status.name.camelCase.toString(),
            style: TextStyle(
              color: JHelperFunction.getOrderStatusColor(order.status),
            ),
          ),
        ),
      ),
      DataCell(Text('₹${order.totalAmount}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected)=> selected).length;
}
