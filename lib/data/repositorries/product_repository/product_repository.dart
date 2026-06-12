// ignore_for_file: avoid_print

import 'package:admin/features/shop/models/product_category_model.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/exception/firebase_exception.dart';
import 'package:admin/utils/exception/format_exception.dart';
import 'package:admin/utils/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> createProduct(ProductsModel product) async {
    try {
      final result = await _db.collection('products').add(product.toJson());
      // Save the generated Firestore ID as productId in the document
      await _db
          .collection('products')
          .doc(result.id)
          .update({'productId': result.id});
      return result.id;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final result = await _db
          .collection('productsCategory')
          .add(productCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateProduct(ProductsModel product) async {
    try {
      await _db.collection('products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection('products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductsModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('products').get();
      print("Fetched ${snapshot.docs.length} products");
      return snapshot.docs
          .map((querySnapshot) => ProductsModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e, stacktrace) {
      print("🔥 ERROR: $e");
      print("📌 STACKTRACE: $stacktrace");
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductCategoryModel>> getProductsCategories(
      String productId) async {
    try {
      final snapshot = await _db
          .collection('productsCategory')
          .where('productId', isEqualTo: productId)
          .get();
      return snapshot.docs
          .map((querySnapshot) =>
              ProductCategoryModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> deleteProduct(ProductsModel product) async {
    try {
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('products').doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception('Product Not Found');
        }
        final productCategoriesSnapshot = await _db
            .collection('productsCategory')
            .where('productId', isEqualTo: product.id)
            .get();
        final productCategories = productCategoriesSnapshot.docs
            .map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(
                _db.collection('productsCategory').doc(productCategory.id));
          }
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  removerProductCategory(String productId, String categoryId) async {
    try {
      final result = await _db
          .collection('productsCategory')
          .where('productId', isEqualTo: productId)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      for (final doc in result.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductsModel>> getProductsByCategory(String categoryId) async {
    try {
      final mappingSnapshot = await _db
          .collection('productsCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      final productIds = mappingSnapshot.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      if (productIds.isEmpty) return [];

      List<ProductsModel> products = [];

      // Split productIds into chunks of 10-30 items to avoid Firestore limit
      const int chunkSize = 10;
      for (var i = 0; i < productIds.length; i += chunkSize) {
        final chunk = productIds.sublist(
          i,
          i + chunkSize > productIds.length ? productIds.length : i + chunkSize,
        );

        final productsSnapshot = await _db
            .collection('products')
            .where(FieldPath.documentId, whereIn: chunk)
            .get();

        final chunkProducts = productsSnapshot.docs
            .map((doc) => ProductsModel.fromSnapshot(doc))
            .toList();

        products.addAll(chunkProducts);
      }

      return products;
    } catch (e) {
      print("🔥 Error loading products by category: $e");
      throw 'Failed to load products for category';
    }
  }
}
