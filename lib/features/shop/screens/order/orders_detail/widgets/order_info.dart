// ignore_for_file: deprecated_member_use

import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status;
    return JRoundedContainer(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(order.formattedOrderDate,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text('${order.items.length} Items',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              Expanded(
                flex: JDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    Obx(() {
                      if(controller.statusLoader.value)return const JShimmerEffect(width: double.infinity, height: 55);
                      return JRoundedContainer(
                        radius: JSizes.cardRadiusSm,
                        padding: const EdgeInsets.symmetric(
                            horizontal: JSizes.sm, vertical: 0),
                        backgroundColor:
                            JHelperFunction.getOrderStatusColor(controller. orderStatus.value)
                                .withOpacity(0.1),
                        child: DropdownButton<OrderStatus>(
                          padding: const EdgeInsets.symmetric(
                              horizontal: JSizes.sm, vertical: 0),
                          value:controller. orderStatus.value,
                          onChanged: (OrderStatus? newValue) {
                            if(newValue != null){
                              controller.updateOrderStatus(order, newValue);
                            }
                          },
                          items: OrderStatus.values.map((OrderStatus status) {
                            return DropdownMenuItem<OrderStatus>(
                                value: status,
                                child: Text(status.name.capitalize.toString(),
                                    style: TextStyle(
                                      color:
                                          JHelperFunction.getOrderStatusColor(
                                             controller. orderStatus.value),
                                    )));
                          }).toList(),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total'),
                  Text('₹${order.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
