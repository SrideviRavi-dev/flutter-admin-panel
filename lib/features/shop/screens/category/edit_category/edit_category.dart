import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:admin/features/shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:admin/features/shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments as CategoryModel?; // Ensure it's a CategoryModel
    if (category == null) {
      // If category is null, show an error or navigate away
      return Scaffold(
        body: Center(child: Text("Category not found")),
      );
    }
    return JSiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category),
      tablet: EditCategoryTabletScreen(category: category),
      mobile: EditCategoryMobileScreen(category: category),
    );
  }
}
