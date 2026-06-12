import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/common/widgets/shimmer_effect/shimmer_effect.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/controller/category/create_category_controller.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());
    return JRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(JSizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: JSizes.sm,
            ),
            Text('Create New Category',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: JSizes.spaceBtwSections),
            TextFormField(
              controller: createController.name,
              validator: (value) => JValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category)),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              () => categoryController.isLoading.value
                  ? const JShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField(
                      decoration: const InputDecoration(
                          hintText: 'Parent Category',
                          labelText: 'Parent Category',
                          prefixIcon: Icon(Iconsax.bezier)),
                      onChanged: (newValue) =>
                          createController.selectedParent.value = newValue!,
                      items: categoryController.allItems
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.name),
                                ],
                              )))
                          .toList()),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              ()=> JImageUploader(
                width: 80,
                height: 80,
                image: createController.imageURL.value.isNotEmpty ? createController.imageURL.value : JImages.photo,
                imageType:createController.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                onIconButtonPressed: ()=> createController.pickImage(),
              ),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              ()=> CheckboxMenuButton(
                  value: createController.isFeatured.value,
                  onChanged: (value) => createController.isFeatured.value = value ?? false,
                  child: const Text('Featured')),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () => createController.createCategory(), child: const Text('Create')),
            ),
            const SizedBox(
              height: JSizes.spaceBtwInputFields * 2,
            )
          ],
        ),
      ),
    );
  }
}
