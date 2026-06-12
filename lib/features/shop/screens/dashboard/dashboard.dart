import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/dashboard/responsive_screen/dashboard_desktop_screen.dart';
import 'package:admin/features/shop/screens/dashboard/responsive_screen/dashboard_mobile_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(desktop: DashboardDesktopScreen(),mobile: DashboardMobileScreen(),);
  }
}