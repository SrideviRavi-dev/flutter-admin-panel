import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/order/all_orders/responsive_screens/order_desktop_screen.dart';
import 'package:admin/features/shop/screens/order/all_orders/responsive_screens/order_mobile_screen.dart';
import 'package:admin/features/shop/screens/order/all_orders/responsive_screens/order_tablet_screen.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JSiteTemplate(
        desktop: OrderDesktopScreen(),
        tablet: OrderTabletScreen(),
        mobile: OrderMobileScreen());
  }
}
