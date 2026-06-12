import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/product/all_product/reponsive_screens/product_desktop_screen.dart';
import 'package:admin/features/shop/screens/product/all_product/reponsive_screens/product_mobile_screen.dart';
import 'package:admin/features/shop/screens/product/all_product/reponsive_screens/product_tablet_screen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: ProductDesktopScreen(),
      tablet: ProductTabletScreen(),
      mobile: ProductMobileScreen(),
    );
  }
}