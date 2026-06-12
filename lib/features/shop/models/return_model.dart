// models/return_request_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ReturnRequestModel {
  final String id;
  final String orderId;
  final String productId;
  final String title;
  final String userId;
  final String reason;
  final String status;
  final DateTime timestamp;

  ReturnRequestModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.title,
    required this.userId,
    required this.reason,
    required this.status,
    required this.timestamp,
  });

  factory ReturnRequestModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReturnRequestModel(
      id: doc.id,
      orderId: data['orderId'] ?? '',
      productId: data['productId'] ?? '',
      title: data['title'] ?? '',
      userId: data['userId'] ?? '',
      reason: data['reason'] ?? '',
      status: data['status'] ?? 'pending',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
