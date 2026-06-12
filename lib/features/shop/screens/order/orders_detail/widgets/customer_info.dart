import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/shop/controller/order/order_detail_controller.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JRoundedContainer(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: JSizes.spaceBtwSections),
              Obx(() {
                return Row(
                  children: [
                    JRoundedImage(
                      padding: 0,
                      backgroundColor: JColors.primaryBackground,
                      image: controller.customer.value.profilePicture.isNotEmpty
                          ? controller.customer.value.profilePicture
                          : JImages.user,
                      imageType:
                          controller.customer.value.profilePicture.isNotEmpty
                              ? ImageType.network
                              : ImageType.asset,
                    ),
                    const SizedBox(width: JSizes.spaceBtwItems),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        Text(controller.customer.value.email,
                            overflow: TextOverflow.ellipsis, maxLines: 1),
                      ],
                    ))
                  ],
                );
              }),
              const SizedBox(height: JSizes.spaceBtwSections),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: JRoundedContainer(
                    padding: EdgeInsets.all(JSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Person',
                            style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        Text(controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: JSizes.spaceBtwItems / 2),
                        Text(controller.customer.value.email,
                            style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: JSizes.spaceBtwItems / 2),
                        Text(
                            controller
                                    .customer.value.formattedPhoneNo.isNotEmpty
                                ? controller.customer.value.formattedPhoneNo
                                : '(+91) ** ****',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: JRoundedContainer(
                  padding: const EdgeInsets.all(JSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Address',
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      Text(order.address != null ? order.address!.name : '',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: JSizes.spaceBtwItems / 2),
                      Text(
                          order.address != null
                              ? order.address!.toString()
                              : '',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
            ],
          ),
        )
      ],
    );
  }
}
