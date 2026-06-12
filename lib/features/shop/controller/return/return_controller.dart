// controllers/return_controller.dart

import 'package:admin/features/shop/models/return_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReturnController extends GetxController {
  RxList<ReturnRequestModel> returnRequests = <ReturnRequestModel>[].obs;

  Future<void> fetchReturns() async {
    final result = await FirebaseFirestore.instance
        .collection('returns')
        .orderBy('timestamp', descending: true)
        .get();

    final requests = result.docs
        .map((doc) => ReturnRequestModel.fromSnapshot(doc))
        .toList();

    returnRequests.assignAll(requests);
  }
}
