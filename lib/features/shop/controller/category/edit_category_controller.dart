import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/category_repository/category_repository.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/shop/controller/category/category_controller.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void init(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if (category.parentId.isNotEmpty) {
      var parentCategory = CategoryController.instance.allItems
          .where((c) => c.id == category.parentId)
          .firstOrNull;

      if (parentCategory != null) {
        selectedParent.value = parentCategory;
      }
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      JFullScreenLoader.popUpCircular();
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        JFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        JFullScreenLoader.stopLoading();
        return;
      }
      category.image = imageURL.value;
      category.name = name.text.trim();
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      await CategoryRepository.instance.updateCategory(category);

      CategoryController.instance.updateItemFromLists(category);

      resetFields();

      JFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Congratulation', message: 'Your Record has been updated ');
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }
  
}
