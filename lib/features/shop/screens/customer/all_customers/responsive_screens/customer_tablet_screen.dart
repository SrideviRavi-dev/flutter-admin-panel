import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/data_table/table_header.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/customer/customer_controller.dart';
import 'package:admin/features/shop/screens/customer/all_customers/table/data_table.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerTabletScreen extends StatelessWidget {
  const CustomerTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                  heading: 'Customers', breadcrumbItems: ['Customers']),
              const SizedBox(height: JSizes.spaceBtwSections),
              JRoundedContainer(
                child: Column(
                  children: [
                    JTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                    ),
                    SizedBox(height: JSizes.spaceBtwSections),
                    Obx(() {
                      if(controller.isLoading.value) return const JLoaderAnimation();
                      return CustomerTable();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
