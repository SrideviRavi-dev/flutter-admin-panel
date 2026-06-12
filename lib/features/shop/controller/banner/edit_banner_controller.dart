import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/banner_repository/banner_repository.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/shop/controller/banner/banner_controller.dart';
import 'package:admin/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  Future<void> updateBanner(BannerModel banner) async {
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

      if (banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value ||banner.active != isActive.value) {
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        
        await repository.updateBanner(banner);
      }

      BannerController.instance.updateItemFromLists(banner);
      JFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record has been updated');
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
