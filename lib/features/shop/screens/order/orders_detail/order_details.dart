// ignore_for_file: unused_local_variable

import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/order/orders_detail/reponsive_screen.dart/order_detail_desktop_screen.dart';
import 'package:admin/features/shop/screens/order/orders_detail/reponsive_screen.dart/order_detail_mobile_screen.dart';
import 'package:admin/features/shop/screens/order/orders_detail/reponsive_screen.dart/order_detail_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return  JSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      tablet: OrderDetailTabletScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}