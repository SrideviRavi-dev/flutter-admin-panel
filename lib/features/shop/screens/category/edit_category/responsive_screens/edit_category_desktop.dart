import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:admin/features/shop/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditCategoryDesktopScreen extends StatelessWidget {
  const EditCategoryDesktopScreen({super.key, required this.category});

final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Update Category', breadcrumbItems: [JRoutes.categories,'Update Category']),
              const SizedBox(height: JSizes.spaceBtwSections),

              EditCategoryForm(category:category),
            ],
          ),
        ),
      ),
    );
  }
}
