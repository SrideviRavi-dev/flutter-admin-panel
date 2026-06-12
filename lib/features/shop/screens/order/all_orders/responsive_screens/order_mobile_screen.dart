import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/data_table/table_header.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/features/shop/screens/order/all_orders/table/data_table.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderMobileScreen extends StatelessWidget {
  const OrderMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
   
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JBreadcrumbsWithHeading(heading: 'Orders', breadcrumbItems: ['Orders']),
              SizedBox(height: JSizes.spaceBtwSections),
              JRoundedContainer(
                child: Column(
                  children: [
                    JTableHeader(showLeftWidget: false),
                    SizedBox(height: JSizes.spaceBtwItems),
                    
                   Obx(() {
                      if (controller.isLoading.value) return const JLoaderAnimation();
                      return const OrderTable();
                    }),
                  ],
                ),
              ),
            ],
          ),
          ),
      ),
    );
  }
}