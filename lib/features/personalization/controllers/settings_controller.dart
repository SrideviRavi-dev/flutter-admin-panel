import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/settings/settings_repository.dart';
import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/personalization/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController{
  static SettingsController get instance => Get.find();
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit(){
    fetchSettingDetails();
    super.onInit();
  }

  Future<SettingsModel> fetchSettingDetails()async{
    try{
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text = settings.freeShippingThreshold == null ? '': settings.freeShippingThreshold.toString();
      loading.value = false;
      return settings;
    }catch(e){
      JLoaders.errorSnackBar(title: 'Something went worng.',message: e.toString());
      return SettingsModel();
    }
   }

  void updateAppLogo() async{
    try{
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        ImageModel selectedImage = selectedImages.first;

        await settingRepository.updateSingleField({'appLogo':selectedImage.url});
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        JLoaders.successSnackBar(title: 'Conguratulations',message: 'App Logo has been updated');
      }
      loading.value = false;

    }catch(e){
      loading.value = false;
      JLoaders.errorSnackBar(title: 'Oh Snap!',message:  e.toString());
    }
  }

  void updateSettingInformation() async{
    try{
      loading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        JFullScreenLoader.stopLoading();
        return;
      }
      if(!formKey.currentState!.validate()){
        JFullScreenLoader.stopLoading();
        return;
      }
      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate = double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim())?? 0.0;
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim())?? 0.0;

      await settingRepository.updateSettingDetails(settings.value);
      settings.refresh();
      
      loading.value = false;
      JLoaders.successSnackBar(title: 'Congratulations',message: 'App Settings has been updated');
    }catch(e){
      loading.value = false;
      JLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
}