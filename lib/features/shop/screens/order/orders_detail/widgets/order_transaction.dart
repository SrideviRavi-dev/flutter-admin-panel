import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transaction',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                  flex: JDeviceUtils.isMobileScreen(context) ? 2 : 1,
                  child: Row(
                    children: [
                      const JRoundedImage(
                        imageType: ImageType.asset,
                        image: JImages.logo,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment via ${order.paymentMethod.capitalize}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              '${order.paymentMethod.capitalize} fee \$25',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('April 21 , 2025',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total',style: Theme.of(context).textTheme.labelMedium),
                          Text('₹${order.totalAmount}',style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ))
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
