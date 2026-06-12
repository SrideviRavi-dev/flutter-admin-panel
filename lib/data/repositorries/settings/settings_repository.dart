import 'package:admin/utils/exception/firebase_auth_exception.dart';
import 'package:admin/utils/exception/format_exception.dart';
import 'package:admin/utils/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/settings_model.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> registerSettings(SettingsModel setting) async {
    try {
      await _db
          .collection('settings')
          .doc('GLOBAL_SETTINGS')
          .set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<SettingsModel> getSettings() async {
    try {
      final querySnapshot =
          await _db.collection('settings').doc('GLOBAL_SETTINGS').get();
      return SettingsModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
   Future<void> updateSettingDetails(SettingsModel updatedSetting) async {
    try {
      await _db
          .collection('settings')
          .doc('GLOBAL_SETTINGS')
          .update(updatedSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
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
          .collection('settings')
          .doc('GLOBAL_SETTINGS')
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw JFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const JFormatException();
    } on PlatformException catch (e) {
      throw JPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
