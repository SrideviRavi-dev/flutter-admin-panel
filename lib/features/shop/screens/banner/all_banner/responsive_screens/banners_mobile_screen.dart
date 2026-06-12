import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/data_table/table_header.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/banner/banner_controller.dart';
import 'package:admin/features/shop/screens/banner/all_banner/table/data_table.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersMobileScreen extends StatelessWidget {
  const BannersMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
   return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            const JBreadcrumbsWithHeading(heading: 'Banners', breadcrumbItems: ['Banners']),
            const SizedBox(height:  JSizes.spaceBtwSections),

            Obx(
              (){
               if (controller.isLoading.value) return const JLoaderAnimation();

                return JRoundedContainer(
                child: Column(
                  children: [
                    JTableHeader(buttonText: 'Create New Banner', onPressed: ()=> Get.toNamed(JRoutes.createBanner)),
                    const SizedBox(height: JSizes.spaceBtwItems),
              
                    const BannersTable(),
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