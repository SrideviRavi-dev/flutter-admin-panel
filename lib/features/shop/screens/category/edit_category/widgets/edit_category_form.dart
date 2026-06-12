import 'package:admin/common/widgets/container/rounded_container.dart';
import 'package:admin/common/widgets/images/image_uploader.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/controller/category/edit_category_controller.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    editController.init(category);
    final categoryController = Get.put(CategoryController());
    return JRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(JSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: JSizes.sm,
            ),
            Text('Update  Category',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: JSizes.spaceBtwSections),
            TextFormField(
              controller: editController.name,
              validator: (value) => JValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category)),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              () => DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                    hintText: 'Parent Category',
                    labelText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier)),
                value: editController.selectedParent.value.id.isNotEmpty
                    ? editController.selectedParent.value
                    : null,
                onChanged: (newValue) =>
                    editController.selectedParent.value = newValue!,
                items: categoryController.allItems
                    .map((item) => DropdownMenuItem(
                        value: item,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item.name),
                          ],
                        )))
                    .toList(),
              ),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              () => JImageUploader(
                width: 80,
                height: 80,
                image: editController.imageURL.value.isNotEmpty
                    ? editController.imageURL.value
                    : JImages.photo,
                imageType: editController.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => editController.pickImage(),
              ),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            Obx(
              () => CheckboxMenuButton(
                  value: editController.isFeatured.value,
                  onChanged: (value) =>
                      editController.isFeatured.value = value ?? false,
                  child: const Text('Featured')),
            ),
            SizedBox(height: JSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => editController.updateCategory(category),
                  child: const Text('Update')),
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
