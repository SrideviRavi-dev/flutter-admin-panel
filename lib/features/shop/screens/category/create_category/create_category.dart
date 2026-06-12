import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/category/create_category/responsive_screens/create_category_desktop_screen.dart';
import 'package:admin/features/shop/screens/category/create_category/responsive_screens/create_category_mobile_screen.dart';
import 'package:admin/features/shop/screens/category/create_category/responsive_screens/create_category_tablet_screen.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CreateCategoryTabletScreen(),
      mobile:CreateCategoryMobileScreen(),
    );
  }
}