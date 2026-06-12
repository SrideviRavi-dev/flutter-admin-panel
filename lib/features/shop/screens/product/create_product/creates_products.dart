import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/product/create_product/reponsive_screen/create_product_desktop.dart';
import 'package:admin/features/shop/screens/product/create_product/reponsive_screen/create_product_mobile.dart';
import 'package:flutter/material.dart';

class CreatesProductsScreen extends StatelessWidget {
  const CreatesProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      tablet: CreateProductMobileScreen(),
    );
  }
}