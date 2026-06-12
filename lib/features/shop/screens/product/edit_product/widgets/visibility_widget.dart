import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility',style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: JSizes.spaceBtwItems),
          Column(
            children: [
              _buildVisibilityRadioButton(ProductVisibility.pulished, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden,'Hidden'),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildVisibilityRadioButton(ProductVisibility value, String label){
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: ProductVisibility.pulished,
      onChanged: (selected) {},
      child: Text(label),
      );
  }
}