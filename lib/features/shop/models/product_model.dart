// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:admin/features/shop/models/color_option_model.dart';
import 'package:admin/features/shop/models/product_attribute_model.dart';
import 'package:admin/features/shop/models/product_variation_model.dart';
import 'package:admin/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  String id;
  String title;
  double price;
  double salePrice;
  List<String>? imageUrls;
  String? discountPercentage;
  List<String>? description;
  String? categoryId;
  String productType;
  int stock;
  String thumbnail;
  int soldQuantity;
  List<String>? colors;
  List<ProductOption>? colorOptions;
  List<String>? sizes;
  String? selectedColor;
  String? selectedSize;
  int quantity;
  DateTime? date;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    this.salePrice = 0.0,
    this.imageUrls,
    this.discountPercentage,
    this.description,
    this.categoryId,
    required this.productType,
    required this.stock,
    required this.thumbnail,
    this.soldQuantity = 0,
    this.colors,
    this.colorOptions,
    this.sizes,
    this.date,
    this.selectedColor,
    this.selectedSize,
    this.quantity = 1,
    this.productAttributes,
    this.productVariations,
  });

  String get formattedDate => JFormatter.formatDate(date);

  factory ProductsModel.empty() => ProductsModel(
        id: '',
        title: '',
        price: 0,
        productType: '',
        stock: 0,
        thumbnail: '',
      );

  toJson() {
    return {
     // 'id': id,
      'title': title,
      'price': price,
      'salePrice': salePrice,
      'imageUrls': imageUrls ?? [],
      'discountPercentage': discountPercentage,
      'description': description,
      'categoryId': categoryId,
      'productType': productType,
      'stock': stock,
      'thumbnail': thumbnail,
      'soldQuantity': soldQuantity,
      'colors': colors ?? [],
      'colorOptions': colorOptions != null
          ? colorOptions!.map((e) => e.toJson()).toList()
          : [],
      'sizes': sizes ?? [],
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'quantity': quantity,
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductsModel.empty();
    final data = document.data()!;
    return ProductsModel(
      id: document.id,
      title: data['title'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      imageUrls:
          data['imageUrls'] != null ? List<String>.from(data['imageUrls']) : [],
      discountPercentage: data['discountPercentage'] ?? null,
      description: List<String>.from(data['description'] ?? []),
      categoryId: data['categoryId'] ?? '',
      productType: data['productType'] ?? '',
      stock: data['stock'] ?? 0,
      thumbnail: data['thumbnail'] ?? '',
      soldQuantity:
          data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
      colors: data['colors'] != null ? List<String>.from(data['colors']) : null,
      colorOptions: data['colorOptions'] != null
          ? (data['colorOptions'] as List)
              .map((e) => ProductOption.fromJson(e))
              .toList()
          : null,
      sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : null,
      selectedColor: data['selectedColor'],
      selectedSize: data['selectedSize'],
      quantity: data['quantity'] ?? 1,
      productAttributes: (data['productAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductsModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductsModel(
      id: document.id,
      title: data['title'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      imageUrls:
          data['imageUrls'] != null ? List<String>.from(data['imageUrls']) : [],
      discountPercentage: data['discountPercentage'] ?? null, 
      description: List<String>.from(data['description'] ?? []),
      categoryId: data['categoryId'] ?? '',
      productType: data['productType'] ?? '',
      stock: data['stock'] ?? 0,
      thumbnail: data['thumbnail'] ?? '',
      soldQuantity:
          data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
      colors: data['colors'] != null ? List<String>.from(data['colors']) : null,
      colorOptions: data['colorOptions'] != null
          ? (data['colorOptions'] as List)
              .map((e) => ProductOption.fromJson(e))
              .toList()
          : null,
      sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : null,
      selectedColor: data['selectedColor'],
      selectedSize: data['selectedSize'],
      quantity: data['quantity'] ?? 1,
      productAttributes: (data['productAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['productVariations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
