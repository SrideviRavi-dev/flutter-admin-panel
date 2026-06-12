import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/screens/banner/create_banner/widgets/create_banner_form.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannerDesktopScreen extends StatelessWidget {
  const CreateBannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                JBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Create Banner', breadcrumbItems: [JRoutes.banners,'Create Banner']),
                SizedBox(height: JSizes.spaceBtwSections),

                CreateBannerForm(),
            ],
          ),
           ),
      ),
    );
  }
}