import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/data_table/table_header.dart';
import 'package:admin/features/shop/screens/category/all_categories/table/date_table.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CategoriesMobileScreen extends StatelessWidget {
  const CategoriesMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                  heading: 'Categories', breadcrumbItems: ['Categories']),
              const SizedBox(height: JSizes.spaceBtwSections),
              JRoundedContainer(
                child: Column(
                  children: [
                    JTableHeader(
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(JRoutes.createCategory),
                    searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                    ),
                    SizedBox(height: JSizes.spaceBtwSections),
                    CategoryTable(),
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
