// ignore_for_file: avoid_print

import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/exception/firebase_exception.dart';
import 'package:admin/utils/exception/format_exception.dart';
import 'package:admin/utils/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {  
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

    // Real-time order stream
 

  Future<List<OrderModel>> getAllOrder() async {
  try {
    final result = await _db.collection('orders').get();

    print("Fetched orders count: ${result.docs.length}");

    return result.docs.map((documentSnapshot) {
      return OrderModel.fromSnapshot(documentSnapshot);
    }).toList();
  } catch (e, stacktrace) {
    print("Error fetching orders from Firestore: $e");
    print(stacktrace);
    rethrow;
  }
}


 Future<void> addOrder(OrderModel order) async {
  try {
    final now = DateTime.now();
    final deliveryDate = now.add(const Duration(days: 9));

    // Create a copy of the order with deliveryDate set
    final updatedOrder = OrderModel(
      id: order.id,
      docId: order.docId,
      userId: order.userId,
      status: order.status,
      items: order.items,
      totalAmount: order.totalAmount,
      taxCost: order.taxCost,
      orderDate: now,
      paymentMethod: order.paymentMethod,
      address: order.address,
      trackingNumber: order.trackingNumber,
      deliveryDate: deliveryDate,
    );

    await _db.collection('orders').add(updatedOrder.toJson());
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


  Future<void> updateOrderSpecificValues(
      String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection('orders').doc(orderId).update(data);
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

  Future<void> deleteOrder(
    String orderId,
  ) async {
    try {
      await _db.collection('orders').doc(orderId).delete();
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
}
