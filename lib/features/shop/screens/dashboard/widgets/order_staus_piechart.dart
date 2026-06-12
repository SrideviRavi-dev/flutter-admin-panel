// ignore_for_file: unnecessary_string_interpolations

import 'package:admin/common/widgets/container/circular_container.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/dashboard/dashboard_controller.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Orders Status',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwSections),
          Obx(
            () => controller.orderStatusData.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: PieChart(
                      PieChartData(
                          sectionsSpace: 2,
                          sections:
                              controller.orderStatusData.entries.map((entry) {
                            final status = entry.key;
                            final count = entry.value;

                            return PieChartSectionData(
                              showTitle: true,
                              title: '$count',
                              value: count.toDouble(),
                              radius: 100,
                              color:
                                  JHelperFunction.getOrderStatusColor(status),
                              titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }).toList(),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {},
                            enabled: true,
                          )),
                    ),
                  )
                : const SizedBox(
                    height: 400,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [JLoaderAnimation()])),
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DataTable(
                columns: const [
                  DataColumn(
                    label: Text('Status'),
                  ),
                  DataColumn(
                    label: Text('Orders'),
                  ),
                  DataColumn(
                    label: Text('Totle'),
                  ),
                ],
                rows: controller.orderStatusData.entries.map((entry) {
                  final OrderStatus status = entry.key;
                  final int count = entry.value;
                  final totalAmount = controller.totalAmount[status]!;
                  final String displatyStatus =
                      controller.getDisplayStatus(status);
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        JCircularContainer(
                            width: 20,
                            height: 20,
                            backgroundColor:
                                JHelperFunction.getOrderStatusColor(status)),
                        Expanded(child: Text('$displatyStatus')),
                      ],
                    )),
                    DataCell(Text(count.toString())),
                    DataCell(Text('₹${totalAmount.toStringAsFixed(2)}')),
                  ]);
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
