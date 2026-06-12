import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/user/user_repositories.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdmineDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      JLoaders.errorSnackBar(
          title: 'Something went wrong', message: e.toString());
      return UserModel.empty();
    }
  }

  void updateProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        ImageModel selectedImage = selectedImages.first;

        await userRepository
            .updateSingleField({'ProfilePicture': selectedImage.url});
        Future.microtask(() {
          user.value.profilePicture = selectedImage.url;
          user.refresh();
        });
        JLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your profile picture has been updated');
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      JLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void updateUserInformation() async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        JFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        JFullScreenLoader.stopLoading();
        return;
      }
      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();
      loading.value = false;
      JLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your profile has been updated');
    } catch (e) {
      loading.value = false;
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
