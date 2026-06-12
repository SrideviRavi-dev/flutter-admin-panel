import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String id;
  final String categoryId;
  final String productId;

  ProductCategoryModel({
    this.id = '',
    required this.categoryId,
    required this.productId,
  });

  static ProductCategoryModel empty() =>
      ProductCategoryModel(id: '', categoryId: '', productId: '');

  Map<String, dynamic> toJson() {
    return {
      
      'categoryId': categoryId,
      'productId': productId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ProductCategoryModel(
        id: document.id,
        categoryId: data['categoryId'] as String,
        productId: data['productId'] as String,
      );
    } else {
      return ProductCategoryModel.empty();
    }
  }
}
