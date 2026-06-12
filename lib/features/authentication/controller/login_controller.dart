// ignore_for_file: unused_element

import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/authentication/authentication_repository.dart';
import 'package:admin/data/repositorries/settings/settings_repository.dart';
import 'package:admin/data/repositorries/user/user_repositories.dart';
import 'package:admin/features/authentication/controller/user_controller.dart';
import 'package:admin/features/personalization/models/settings_model.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      JFullScreenLoader.openLoadingDialog(
          'Loggin you in....', JImages.processingdata);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        JFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        JFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      await AuthenticationRepository.instance
          .loginwithEmailAndPassword(email.text.trim(), password.text.trim());

      final user = await UserController.instance.fetchUserDetails();

      JFullScreenLoader.stopLoading();

      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        JLoaders.errorSnackBar(
            title: 'Not Authorized',
            message: 'You are not authorized or do have access. Connect Admin');
      } else {
         AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> registerAdmin() async {
    try {
      JFullScreenLoader.openLoadingDialog(
          'Registering Admin Account....', JImages.processingdata);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        JFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.registerwithEmailAndPassword(
          JTexts.adminEmail, JTexts.adminPassword);

      // Force Firebase to reload the current user after registration
      //await FirebaseAuth.instance.currentUser?.reload();

      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'Jd',
          lastName: 'Admin',
          email: JTexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      final settingsRepository  = Get.put(SettingsRepository());
      await settingsRepository.registerSettings(SettingsModel(appLogo: '',appName: 'Jardion',taxRate: 0,shippingCost: 0));


      JFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

      // Check if the user is authenticated before redirecting
      // if (AuthenticationRepository.instance.isAuthenticated) {
      //  AuthenticationRepository.instance.screenRedirect();
      // } else {
      //   JLoaders.errorSnackBar(
      //       title: 'Authentication Failed', message: 'User could not be authenticated');
      // }
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
