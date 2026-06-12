// ignore_for_file: unused_local_variable, unnecessary_type_check, avoid_print

import 'dart:typed_data';

import 'package:admin/common/widgets/loader/circular_loader.dart';
import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/media/media_repository.dart';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/features/media/screens/media/widgets/media_content.dart';
import 'package:admin/features/media/screens/media/widgets/media_uploader.dart';
import 'package:admin/utils/constants/colors.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/constants/image_string.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:admin/utils/constants/text_strings.dart';
import 'package:admin/utils/popups/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_dropzone_web/file/dropzone_file_web.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneController;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxBool showImagesUploaderSection = false.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImageFromDatabase(
          selectedPath.value, initialLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      JLoaders.errorSnackBar(
          title: 'Oh snap',
          message: 'Unable to fetch Images,Something went wrong.Try Again');
    }
  }

  loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          initialLoadCount,
          targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      JLoaders.errorSnackBar(
          title: 'Oh snap',
          message: 'Unable to fetch Images,Something went wrong.Try Again');
    }
  }

  Future<void> selectLocalImages() async {
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);
    print('Files selected: $files'); // Debugging line

    if (files.isNotEmpty) {
      for (var file in files) {
        if (file is DropzoneFileWeb) {
          // This handles DropzoneFileWeb instance properly
          final bytes = await dropzoneController.getFileData(file);
          final image = ImageModel(
            url: '',
            file: file,
            folder: '',
            filename: file.name,
            localImageToDisplay: Uint8List.fromList(bytes),
          );
          selectedImagesToUpload.add(image);
          print('Image added: ${image.filename}'); // Debugging line
        }
      }
    }
  }

  void uploadImagesConfrimation() {
    if (selectedPath.value == MediaCategory.folders) {
      JLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please slecet the folder in order to upload the images');
      return;
    }
    JDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
          'Are you sure you want to upload all the Images in ${selectedPath.value.name.toUpperCase()} folder?',
    );
  }

  Future<void> uploadImages() async {
    try {
      Get.back(); // Close dialog if open
      uploadImagesLoader(); // Show loading screen

      MediaCategory selectedCategory = selectedPath.value;
      RxList<ImageModel> targetList;

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      print('Uploading to path: ${getSelectedPath()}'); // Debugging

      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];

        // ✅ Ensure the file is correctly cast to `html.File`
        if (selectedImage.file is DropzoneFileWeb) {
          final DropzoneFileWeb dropzoneFile =
              selectedImage.file as DropzoneFileWeb;
          final html.File htmlFile = html.File(
              [await dropzoneController.getFileData(dropzoneFile)],
              dropzoneFile.name);

          print('Uploading file: ${selectedImage.filename}'); // Debugging

          final ImageModel uploadedImage =
              await mediaRepository.uploadImageFileInStorage(
                  file: htmlFile,
                  path: getSelectedPath(),
                  imageName: selectedImage.filename);

          uploadedImage.mediaCategory = selectedCategory.name;
          final id =
              await mediaRepository.uploadImageFileInDatabase(uploadedImage);

          uploadedImage.id = id;

          selectedImagesToUpload.removeAt(i);
          targetList.add(uploadedImage);
        }
      }

      JFullScreenLoader.stopLoading();
    } catch (e, stackTrace) {
      JFullScreenLoader.stopLoading();
      print('Upload Error: $e');
      print('Stack Trace: $stackTrace');
      JLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'Something went wrong while uploading your images.');
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Uploading Images'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(JImages.loader, height: 300, width: 300),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  const Text('Sit Tight, Your images are uploading...'),
                ],
              ),
            )));
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = JTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = JTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = JTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = JTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = JTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  void removeCloudImageConfirmation(ImageModel image) {
    JDialogs.defaultDialog(
      context: Get.context!,
      content: 'Are you sure you want to delete the image?',
      onConfirm: () {
        Get.back();

        removeCloudImage(image);
      },
    );
  }

  void removeCloudImage(ImageModel image) async {
    try {
      Get.back();

      Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const PopScope(
              canPop: false,
              child:
                  SizedBox(width: 150, height: 150, child: JCircularLoader())));

      await mediaRepository.deleteFileFromStorage(image);

      RxList<ImageModel> targetList;

      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }
      targetList.remove(image);
      update();

      JFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image sucessfully deleted from your cloud storage');
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFromMedia(
      {List<String>? selectedUrls,
      bool allowSelection = true,
      bool multipleSelection = false}) async {
    showImagesUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: JColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(JSizes.defaultSpace),
            child: Column(
              children: [
                const MediaUploader(),
                MediaContent(
                  allowSelection: allowSelection,
                  alreadySelectedUrls: selectedUrls ?? [],
                  allowMultipleSelection: multipleSelection,
                )
              ],
            ),
          ),
        ),
      ),
    );
    return selectedImages;
  }
}
