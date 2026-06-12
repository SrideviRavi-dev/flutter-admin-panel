import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/device/device_utility.dart';
import 'package:admin/utils/helper/pricing_calculator.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.salePrice * element.quantity));
    return JRoundedContainer(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: JSizes.spaceBtwSections),
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                const SizedBox(height: JSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        JRoundedImage(
                          backgroundColor: JColors.primaryBackground,
                          imageType: item.imageUrls != null
                              ? ImageType.network
                              : ImageType.asset,
                          image: item.imageUrls ?? JImages.logo,
                        ),
                        const SizedBox(width: JSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectedVariation != null)
                                Text(
                                  item.selectedVariation!.entries
                                      .map((e) => ('${e.key}: ${e.value}'))
                                      .join(', '),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              if (item.selectedSize != null && item.selectedSize!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'Size: ${item.selectedSize}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: JSizes.spaceBtwItems),
                  SizedBox(
                      width: JSizes.xl * 2,
                      child: Text('₹${item.salePrice.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  SizedBox(
                    width: JDeviceUtils.isMobileScreen(context)
                        ? JSizes.xl * 1.4
                        : JSizes.xl * 2,
                    child: Text(item.quantity.toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          JRoundedContainer(
            padding: const EdgeInsets.all(JSizes.defaultSpace),
            backgroundColor: JColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('₹$subTotal',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('₹0.00',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '₹${JPricingCalculator.calculateShippingCost(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '₹${JPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: JSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '₹${JPricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
