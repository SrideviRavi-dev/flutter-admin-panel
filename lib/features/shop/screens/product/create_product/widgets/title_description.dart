import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return JRoundedContainer(
      child: Form(
          key: controller.titleDescriptionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Basic Information',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.title,
                validator: (value) =>
                    JValidator.validateEmptyText('Product title', value),
                decoration: const InputDecoration(labelText: 'Product Title'),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              SizedBox(
                height: 300,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  controller: controller.description,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) => JValidator.validateEmptyText(
                      'Product Description', value),
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    hintText: 'Add your Product Description here...',
                    alignLabelWithHint: true,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
