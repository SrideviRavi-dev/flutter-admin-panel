import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/banner_repository/banner_repository.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/shop/controller/banner/banner_controller.dart';
import 'package:admin/features/shop/models/banner_model.dart';
import 'package:admin/routes/app_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageURL.value = selectedImage.url;
    }
  }

  Future<void> createBanner() async {
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

      final newRecord = BannerModel(
        id: '',
        active: isActive.value,
        imageUrl: imageURL.value,
        targetScreen: targetScreen.value,
      );
      newRecord.id = await BannerRepository.instance.createBanner(newRecord);
      BannerController.instance.addItemToLists(newRecord);
      JFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record has been added');
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
