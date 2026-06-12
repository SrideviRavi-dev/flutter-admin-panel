import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/loader/animation_loader.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/shop/controller/customer/customer_detail_controller.dart';
import 'package:admin/features/shop/screens/customer/customer_details/table/data_table.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrderS();
    return JRoundedContainer(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Obx(() {
        if (controller.ordersLoading.value) return const JLoaderAnimation();
        if (controller.allCustomersOrders.isEmpty) {
          return JAnimationLoaderWidget(
            text: 'No Orders found',
            animation: JImages.loading,
          );
        }
        final totalAmount = controller.allCustomersOrders.fold(0.0,
            (previousValue, element) => previousValue + element.totalAmount);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Orders',
                    style: Theme.of(context).textTheme.headlineMedium),
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Total Spent'),
                  TextSpan(
                      text: '\$${totalAmount.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: JColors.primary)),
                  TextSpan(
                      text: 'on ${controller.allCustomersOrders.length}Orders',
                      style: Theme.of(context).textTheme.bodyLarge),
                ]))
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwItems),
            TextFormField(
              controller: controller.serachTextController,
              onChanged: (query) => controller.searchQuery(query),
              decoration: const InputDecoration(
                  hintText: 'Search Orders',
                  prefixIcon: Icon(Iconsax.search_normal)),
            ),
            const SizedBox(height: JSizes.spaceBtwSections),
            const CustomerOrderTable()
          ],
        );
      }),
    );
  }
}
