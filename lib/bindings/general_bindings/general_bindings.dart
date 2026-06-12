import 'package:admin/bindings/services/network_manager.dart';
import 'package:admin/features/authentication/controller/user_controller.dart';
import 'package:admin/features/personalization/controllers/settings_controller.dart';
import 'package:admin/features/shop/controller/product/create_product_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
    void dependencies(){
      Get.lazyPut(()=>NetworkManager(),fenix: true);
      Get.lazyPut(()=>UserController(),fenix: true);
      Get.lazyPut(()=>SettingsController(),fenix: true);
      Get.lazyPut(()=>CreateProductController(),fenix: true);
    }
  
}