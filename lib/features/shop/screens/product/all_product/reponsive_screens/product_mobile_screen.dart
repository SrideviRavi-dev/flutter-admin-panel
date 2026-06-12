import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/data_table/table_header.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/product/product_controller.dart';
import 'package:admin/features/shop/screens/product/all_product/table/products_table.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductMobileScreen extends StatelessWidget {
  const ProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
   return Scaffold(
    body: SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const JBreadcrumbsWithHeading(heading: 'Products', breadcrumbItems: ['Products']),

         Obx(() {
                if (controller.isLoading.value) return const JLoaderAnimation();
                return 
           JRoundedContainer(
            child: Column(
              children: [
                JTableHeader(buttonText: 'Add Product',onPressed: () => Get.toNamed(JRoutes.createProduct)),
                const SizedBox(height: JSizes.spaceBtwItems),
           
                const ProductsTable(),
             ],
            ),
           );
          }
         )
        ],
      ),
      ),
    ),
   );
  }
}