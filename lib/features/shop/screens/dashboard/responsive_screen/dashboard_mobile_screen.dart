// ignore_for_file: deprecated_member_use

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/dashboard/dashboard_controller.dart';
import 'package:admin/features/shop/screens/dashboard/table/data_table.dart';
import 'package:admin/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:admin/features/shop/screens/dashboard/widgets/order_staus_piechart.dart';
import 'package:admin/features/shop/screens/dashboard/widgets/weekly_seals.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(DashboardController());
 return Scaffold(
  backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(padding:const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          children: [
             Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: JSizes.spaceBtwSections),
              Obx(
                ()=> JDashboardWidget(
                        headingIcon: Iconsax.note,
                        headingIconBgColor: Colors.blue.withOpacity(0.1),
                        headingIconColor: Colors.blue,
                        title: 'Sales Total',
                        subTitle:
                            '₹${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                        stats: 25,
                      ),
              ),
              const SizedBox(height: JSizes.spaceBtwItems,),
             Obx(
               ()=>JDashboardWidget(
                        headingIcon: Iconsax.external_drive,
                        headingIconBgColor: Colors.green,
                        headingIconColor: Colors.blue.withOpacity(0.1),
                        icon: Iconsax.arrow_down,
                        color: JColors.error,
                        title: 'Avarage Order Value',
                        subTitle:
                            '₹${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                        stats: 15,
                      ),
             ),
              const SizedBox(height: JSizes.spaceBtwItems,),
             Obx(
               ()=> JDashboardWidget(
                        title: 'Total Orders ',
                        subTitle:
                            '₹${controller.orderController.allItems.length}',
                        stats: 44,
                         headingIcon: Iconsax.box,
                        headingIconBgColor: Colors.deepPurple,
                        headingIconColor: Colors.blue.withOpacity(0.1),
                      ),
             ),
              const SizedBox(height: JSizes.spaceBtwItems),
              Obx(
                ()=> JDashboardWidget(
                         headingIcon: Iconsax.user,
                        headingIconBgColor: Colors.deepOrange,
                        headingIconColor: Colors.blue.withOpacity(0.1),
                        title: 'Vistiors',
                        subTitle: controller.customerController.allItems.length
                            .toString(),
                        stats: 2,
                      ),
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              const JWeeklySalesGraph(),
              const SizedBox(height: JSizes.spaceBtwItems),

               JRoundedContainer(
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                             const SizedBox(height: JSizes.spaceBtwSections,),
                            const  DashboardOrderTable(),
                          ],
                         ),
                        ),
              const SizedBox(height: JSizes.spaceBtwItems),

              const OrderStatusPieChart(),
          ],
        ),
        ),
      ),
      
         );
  }
}
