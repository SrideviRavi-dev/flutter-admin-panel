import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/customer_info.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_info.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_items.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_transaction.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailMobileScreen extends StatelessWidget {
  const OrderDetailMobileScreen({super.key, required this.order});
final OrderModel order;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: order.id,
                  breadcrumbItems: const [JRoutes.orders, 'Details']),
              const SizedBox(height: JSizes.spaceBtwSections),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        OrderInfo(order: order),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        OrderItems(order: order),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        OrderTransaction(order: order)
                      ],
                    ),
                  ),
                  const SizedBox(width: JSizes.spaceBtwSections),
                  Expanded(child: Column(
                    children: [
                      OrderCustomer(order: order),
                      const SizedBox(height:  JSizes.spaceBtwSections),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}