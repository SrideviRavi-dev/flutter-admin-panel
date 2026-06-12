import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/rounded_image.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      padding: const EdgeInsets.all(JSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
               JRoundedImage(
                padding: 0,
                backgroundColor: JColors.primaryBackground,
                image:customer.profilePicture.isNotEmpty ? customer.profilePicture : JImages.user,
                imageType:customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customer.fullName,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                     Text(customer.email,
                        overflow: TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: JSizes.spaceBtwItems / 2),
              Expanded(
                  child: Text(customer.userName,
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: JSizes.spaceBtwItems / 2),
              Expanded(
                  child: Text('India',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: JSizes.spaceBtwItems / 2),
              Expanded(
                  child: Text(customer.phoneNumber,
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwSections),
          const Divider(),
          const SizedBox(height: JSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Order',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('7 Days ago, #[098762]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Averge Order Value',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('\$352'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: JSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registered',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(customer.formattedDate),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Marketing',
                      style: Theme.of(context).textTheme.titleLarge),
                  const Text('Subscribed'),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
