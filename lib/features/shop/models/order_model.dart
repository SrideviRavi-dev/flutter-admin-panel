// ignore_for_file: avoid_print, unnecessary_null_comparison
import 'package:admin/features/personalization/models/address_model.dart';
import 'package:admin/features/shop/models/cart_item_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final String? trackingNumber;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.taxCost,
    required this.orderDate,
    this.trackingNumber,
    this.paymentMethod = 'Gpay',
    this.address,
    this.deliveryDate,
  });

  String get formattedOrderDate => JHelperFunction.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? JHelperFunction.getFormattedDate(deliveryDate!)
      : '';

  String get orderStautsText => status == OrderStatus.delivered
      ? 'Deliverd'
      : status == OrderStatus.shipped
          ? 'Shipment on the way '
          : 'Processing';
  static OrderModel empty() => OrderModel(
        id: '',
        items: [],
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        totalAmount: 0,
        taxCost: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate':
          deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    if (data == null) {
      print("Error: Order document is empty or malformed.");
      throw Exception("Order data is null");
    }

    return OrderModel(
      docId: snapshot.id,
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: OrderStatus.values.firstWhere(
        (e) =>
            e.name.toLowerCase() == (data['status'] ?? 'pending').toLowerCase(),
        orElse: () => OrderStatus.processing,
      ),
      totalAmount:
          data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      taxCost: data.containsKey('taxCost')
          ? (data['taxCost'] as num).toDouble()
          : 0.0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : '',
      address: data.containsKey('shippingAddress')
          ? AddressModel.fromMap(
              data['shippingAddress'] as Map<String, dynamic>)
          : AddressModel.empty(),
      deliveryDate:
          data.containsKey('deliveryDate') && data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
      items: data.containsKey('items') && data['items'] != null
          ? (data['items'] as List<dynamic>)
              .map((itemData) =>
                  CartItemModel.fromJson(itemData as Map<String, dynamic>))
              .toList()
          : [],
      trackingNumber: data['trackingNumber'],
    );
  }
}
