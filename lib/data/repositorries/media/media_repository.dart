// ignore_for_file: avoid_web_libraries_in_flutter, avoid_print

import 'dart:io';
import 'package:admin/features/media/models/image_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ImageModel> uploadImageFileInStorage(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      final Reference ref = _storage.ref('$path/$imageName');
      await ref.putBlob(file);
      final String downloadUrl = await ref.getDownloadURL();

      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          metadata, path, imageName, downloadUrl);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('images')
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> fetchImageFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    print("Fetching images for category: ${mediaCategory.name.toString()}");
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          // .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();
      print("Images fetched: ${querySnapshot.docs.length}");
      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      print("Firebase Exception: ${e.code} - ${e.message}");
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      print("Fetch error: $e");
      throw e.toString();
    }
  }

  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lateFetchedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .startAfter([lateFetchedDate])
          .limit(loadCount)
          .get();
      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance
          .collection('images')
          .doc(image.id)
          .delete();
    } on FirebaseException catch (e) {
      throw e.message ?? 'Somethinf=g went wrong while deleting image.';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
