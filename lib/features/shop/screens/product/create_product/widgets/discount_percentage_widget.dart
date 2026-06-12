import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DiscountPercentageWidget extends StatelessWidget {
  const DiscountPercentageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discount Percentage',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: JSizes.spaceBtwItems),
        TextFormField(
          controller: controller.discountPercentageController,
          decoration: InputDecoration(
            labelText: 'Enter Discount Percentage',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a discount percentage';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
