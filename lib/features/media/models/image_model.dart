// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:typed_data';

import 'package:admin/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'package:universal_html/html.dart' as html;
class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

   final dynamic file; 
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel({
    this.id = '',
    this.mediaCategory = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    required this.filename,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });

  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => JFormatter.formatDate(createdAt);

  String get updatedFormatted => JFormatter.formatDate(updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'mediaCategory': mediaCategory,
      'filename': filename,
      'fullPath': fullPath,
      'contentType': contentType,
      'createdAt': createdAt?.toUtc(),
    };
  }

  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ImageModel(
        id: document.id, // Firestore document ID
        url: data['url'] ?? '', // Fallback to empty string if field is missing
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        mediaCategory: data['mediaCategory'],
        filename: data['filename'] ?? '',
        fullPath: data['fullPath'],
        contentType: data['contentType'] ?? '',
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
      );
    } else {
      return ImageModel.empty();
    }
  }

  factory ImageModel.fromFirebaseMetadata(FullMetadata metadata, String folder,
      String filename, String downloadUrl) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType,
    );
  }
    factory ImageModel.fromHtmlFile(html.File htmlFile, String folder) {
    return ImageModel(
      url: '',  // You can leave this empty or add logic for generating URL
      folder: folder,
      filename: htmlFile.name,
      sizeBytes: htmlFile.size,
      file: htmlFile, // Assign html.File to dynamic file
    );
  }
  // Factory method for handling dart:io.File (for mobile)
  factory ImageModel.fromIoFile(io.File ioFile, String folder) {
    return ImageModel(
      url: '',  // Same as above, you can generate or leave empty
      folder: folder,
      filename: ioFile.path.split('/').last,
      sizeBytes: ioFile.lengthSync(),
      file: ioFile,
    );
  }
}
