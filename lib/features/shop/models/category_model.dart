// ignore_for_file: avoid_print

import 'package:admin/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String image;
  String name;
  bool isFeatured;
  String parentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => JFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => JFormatter.formatDate(updatedAt);

  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

  toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
      'createdAt': createdAt,
      'updatedAt': updatedAt = DateTime.now(),
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        image: data['image'] ?? '',
        name: data['name'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['parentId'] ?? '',
        createdAt: (data['createdAt'] is Timestamp)
            ? (data['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: (data['updatedAt'] is Timestamp)
            ? (data['updatedAt'] as Timestamp).toDate()
            : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
