// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/icon/circular_icon.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/dashboard/dashboard_controller.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class JWeeklySalesGraph extends StatelessWidget {
  const JWeeklySalesGraph({super.key});

   

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              JCircularIcon(icon: Iconsax.graph ,
              backgroundColor: Colors.brown.withOpacity(0.1),
              ),
              Text('Weekly Sales',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            ()=> controller.weeklySales.isNotEmpty
            ? SizedBox(
              height: 400, // Adjust the height as necessary
              child: BarChart(
                  BarChartData(
                    titlesData: buildFlTitlesData(controller.weeklySales),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    gridData: const FlGridData(show: true),
                    barGroups: controller.weeklySales
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                width: 20,
                                color: JColors.primary, // Customize color
                                toY: entry.value,
                                borderRadius: BorderRadius.circular(JSizes.sm),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                        groupsSpace: JSizes.spaceBtwItems,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => JColors.secondary),
                          touchCallback: JDeviceUtils.isDesktopScreen(context) ? (barTouchEvent, barTouchREsponse){} : null,
                    ),
                  ),
                )
             ):const SizedBox(height: 400,child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [JLoaderAnimation()])),
           )
        ],
      ),
    );
  }
   FlTitlesData buildFlTitlesData(List<double> weeklySales) {
    double maxOrder = weeklySales.reduce((a, b)=>a > b ? a : b ).toDouble();
    double stepHeight = (maxOrder / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt();
            return SideTitleWidget(
              space: 0,
              child: Text(
                days[index],
                style: const TextStyle(fontSize: 12),
              ),
              meta: meta,
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: stepHeight <= 0 ? 500 : stepHeight,
          
          reservedSize: 50,
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}


