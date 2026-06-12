// ignore_for_file: avoid_print

import 'package:admin/data/repositorries/authentication/authentication_repository.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/exception/firebase_auth_exception.dart';
import 'package:admin/utils/exception/firebase_exception.dart';
import 'package:admin/utils/exception/format_exception.dart';
import 'package:admin/utils/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
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

  Future<UserModel> fetchAdmineDetails() async {
    try {
      final docSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      return UserModel.fromSnapshot(docSnapshot);
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went Wrong: $e ');
      throw 'Something went Wrong: $e ';
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot =
          await _db.collection('Users').orderBy('FirstName').get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromSnapshot(doc))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went Wrong: $e ');
      throw 'Something went Wrong: $e ';
    }
  }

  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(id).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went Wrong: $e ');
      throw 'Something went Wrong: $e ';
    }
  }

  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    try {
      final documentSnapshot = await _db
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      return documentSnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw JFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went Wrong: $e ');
      throw 'Something went Wrong: $e ';
    }
  }

  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
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

  Future<void> deleteUser(String id) async {
    try {
      await _db.collection('Users').doc(id).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
