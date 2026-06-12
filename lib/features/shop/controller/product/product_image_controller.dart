import 'package:admin/features/media/controllers/media_controller.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class ProductImageController extends GetxController{
  static ProductImageController get instance => Get.find();

  Rx<String?> seletedThumbnailImageUrl = Rx<String?>(null);

  final RxList<String> additionalProdutImagesUrls = <String>[].obs;
  final RxList<String> selectedSizes = <String>[].obs;

  void selectThumbnailImage() async{
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if(selectedImages != null && selectedImages.isNotEmpty){
      ImageModel selectedImage = selectedImages.first;

      seletedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  void selectVariationImage(ProductVariationModel variation)async{
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if(selectedImages != null && selectedImages.isNotEmpty){
      ImageModel selectedImage = selectedImages.first;
      variation.image.value = selectedImage.url;
    }
  }

  void selectMultipleProductImage() async{
      final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia(multipleSelection: true, selectedUrls:additionalProdutImagesUrls );

    if(selectedImages != null && selectedImages.isNotEmpty){
     additionalProdutImagesUrls.assignAll(selectedImages.map((e)=> e.url));
    }
  }

  Future<void> removeImage(int index) async{
    additionalProdutImagesUrls.removeAt(index);
  }

  
}