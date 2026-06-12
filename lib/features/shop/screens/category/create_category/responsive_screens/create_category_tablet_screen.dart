import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/screens/category/create_category/widgets/create_category_form.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateCategoryTabletScreen extends StatelessWidget {
  const CreateCategoryTabletScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Create Category', breadcrumbItems: [JRoutes.categories,'Create Category']),
            SizedBox(height: JSizes.spaceBtwSections),

            CreateCategoryForm(),
          ],
        ),
        ),
      )
    );
  }
}