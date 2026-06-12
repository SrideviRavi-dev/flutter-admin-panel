import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/features/shop/controller/customer/customer_detail_controller.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/customer_info.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/customer_order.dart';
import 'package:admin/features/shop/screens/customer/customer_details/widgets/shipping_address.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  const CustomerDetailDesktopScreen({super.key, required this.customer});
  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               JBreadcrumbsWithHeading(
                heading: customer.fullName,
                breadcrumbItems: [JRoutes.customers, 'Details'],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomerInfo(customer: customer),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        const ShippingAddress(),
                      ],
                    ),
                  ),
                  const SizedBox(width: JSizes.spaceBtwSections),
                  const Expanded(flex: 2, child: CustomerOrders())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
