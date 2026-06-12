import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/customer/all_customers/responsive_screens/customer_desktop_screen.dart';
import 'package:admin/features/shop/screens/customer/all_customers/responsive_screens/customer_mobile_screen.dart';
import 'package:admin/features/shop/screens/customer/all_customers/responsive_screens/customer_tablet_screen.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
      desktop: CustomerDesktopScreen(),
      tablet: CustomerTabletScreen(),
      mobile: CustomerMobileScreen(),
    );
  }
}
