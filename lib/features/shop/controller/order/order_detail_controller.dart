// ignore_for_file: avoid_print

import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/user/user_repositories.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

   // Function to fetch order details
  Future<void> fetchOrderDetails(String orderId) async {
    try {
      loading.value = true;

      // Fetch order from Firestore
      final doc = await FirebaseFirestore.instance.collection('orders').doc(orderId).get();
      
      if (doc.exists) {
        print("Fetched Order: ${doc.data()}"); // Debugging
        order.value = OrderModel.fromSnapshot(doc);
        print("Order Items: ${order.value.items}"); // Debugging
      } else {
        print("Order not found in Firestore");
      }

    } catch (e) {
      JLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;
      final user = await UserRepository.instance.fetchUserDetails(order.value.userId);
      customer.value = user;
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
