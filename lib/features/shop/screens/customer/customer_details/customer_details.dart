// ignore_for_file: unused_local_variable

import 'package:admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:admin/features/shop/screens/customer/customer_details/responsive_screens/customer_detail_desktop.dart';
import 'package:admin/features/shop/screens/customer/customer_details/responsive_screens/customer_detail_mobile.dart';
import 'package:admin/features/shop/screens/customer/customer_details/responsive_screens/customer_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['customerId'];
    return JSiteTemplate(
      desktop: CustomerDetailDesktopScreen(customer: customer),
      tablet: CustomerDetailTabletScreen(customer: customer),
      mobile: CustomerDetailMobileScreen(customer: customer),
    
    );
  }
}