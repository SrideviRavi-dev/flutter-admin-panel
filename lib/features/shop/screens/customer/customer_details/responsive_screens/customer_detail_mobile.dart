import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/customer_info.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/customer_order.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/shipping_address.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer});

  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JBreadcrumbsWithHeading(
                heading: 'Jardion',
                breadcrumbItems: [JRoutes.customers, 'Details'],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              CustomerInfo(customer: customer),
              const SizedBox(height: JSizes.spaceBtwSections),
              const ShippingAddress(),
              const SizedBox(width: JSizes.spaceBtwSections),
              const Expanded(flex: 2, child: CustomerOrders())
            ],
          ),
        ),
      ),
    );
  }
}
