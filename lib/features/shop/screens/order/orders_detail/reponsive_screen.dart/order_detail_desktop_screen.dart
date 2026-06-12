// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/customer_info.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/label_generator.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_info.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_items.dart';
import 'package:admin/features/shop/screens/order/orders_detail/widgets/order_transaction.dart';
import 'package:admin/data/repositorries/order/order_repository.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/routes/routes.dart';

class OrderDetailDesktopScreen extends StatefulWidget {
  const OrderDetailDesktopScreen({super.key, required this.order});
  final OrderModel order;

  @override
  State<OrderDetailDesktopScreen> createState() =>
      _OrderDetailDesktopScreenState();
}

class _OrderDetailDesktopScreenState extends State<OrderDetailDesktopScreen> {
  DateTime? _selectedDate;
  final _trackingController = TextEditingController();
  final _orderRepo = OrderRepository.instance;
  bool _isUpdatingTracking = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.order.deliveryDate;
    _trackingController.text = widget.order.trackingNumber ?? '';
  }

  Future<void> _pickDeliveryDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      await _updateDeliveryDateInFirestore(pickedDate);
    }
  }

  Future<void> _updateDeliveryDateInFirestore(DateTime date) async {
    try {
      if (widget.order.docId.isEmpty) throw Exception('Invalid Order ID');

      final orderRef = FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.order.docId);

      await orderRef.update({'deliveryDate': Timestamp.fromDate(date)});

      setState(() => _selectedDate = date);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Delivery date updated to ${date.toLocal()}")),
      );
    } catch (e) {
      print("Error updating delivery date: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating delivery date: $e")),
      );
    }
  }

  Future<void> _updateTrackingNumber() async {
    try {
      setState(() => _isUpdatingTracking = true);

      final trackingNumber = _trackingController.text.trim();
      if (trackingNumber.isEmpty)
        throw Exception("Tracking number cannot be empty.");

      await _orderRepo.updateOrderSpecificValues(widget.order.docId, {
        'trackingNumber': trackingNumber,
      });

      JLoaders.successSnackBar(
        title: 'Success',
        message: 'Tracking number updated.',
      );
    } catch (e) {
      JLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    } finally {
      setState(() => _isUpdatingTracking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JBreadcrumbsWithHeading(
              returnToPreviousScreen: true,
              heading: widget.order.id,
              breadcrumbItems: const [JRoutes.orders, 'Details'],
            ),
            const SizedBox(height: JSizes.spaceBtwSections),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      OrderInfo(order: widget.order),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      OrderItems(order: widget.order),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      OrderTransaction(order: widget.order),
                      const SizedBox(height: JSizes.spaceBtwSections),

                      /// Delivery Date Section
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _selectedDate != null
                              ? "Delivery Date: ${_selectedDate!.toLocal()}"
                              : "Delivery Date not set",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: JSizes.spaceBtwSections),

                      /// Tracking Number Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Tracking Number",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _trackingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter tracking number',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _isUpdatingTracking
                                    ? null
                                    : _updateTrackingNumber,
                                child: _isUpdatingTracking
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Text("Update"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: JSizes.spaceBtwSections),
                Expanded(
                  child: Column(
                    children: [
                      OrderCustomer(order: widget.order),
                      const SizedBox(height: JSizes.spaceBtwSections),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.qr_code),
                  label: const Text("Print Shipping Label with QR"),
                  onPressed: () async {
                    await LabelGenerator.printLabel(widget.order);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
