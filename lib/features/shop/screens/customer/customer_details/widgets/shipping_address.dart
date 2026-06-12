import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/loader/loader_animation.dart';
import 'package:admin/features/personalization/models/address_model.dart';
import 'package:admin/features/shop/controller/customer/customer_detail_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();
    return Obx(() {
      if (controller.addressesLoading.value) return const JLoaderAnimation();

      AddressModel selectedAddress = AddressModel.empty();
      if (controller.customer.value.address != null) {
        if (controller.customer.value.address!.isNotEmpty) {
          selectedAddress = controller.customer.value.address!
              .where((element) => element.selectedAddress)
              .single;
        }
      }
      return JRoundedContainer(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          children: [
            Text('Address',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: JSizes.spaceBtwSections),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Name')),
                const Text(':'),
                const SizedBox(width: JSizes.spaceBtwSections),
                Expanded(
                    child: Text(selectedAddress.name,
                        style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwSections),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Country')),
                const Text(':'),
                const SizedBox(width: JSizes.spaceBtwSections),
                Expanded(
                    child: Text(selectedAddress.country,
                        style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwSections),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone number')),
                const Text(':'),
                const SizedBox(width: JSizes.spaceBtwSections),
                Expanded(
                    child: Text(selectedAddress.phoneNumber,
                        style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwSections),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Address')),
                const Text(':'),
                const SizedBox(width: JSizes.spaceBtwSections),
                Expanded(
                    child: Text(
                        selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '',
                        style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
          ],
        ),
      );
    });
  }
}
