// screens/returns/return_requests_screen.dart

// ignore_for_file: unnecessary_string_interpolations

import 'package:admin/features/shop/controller/return/return_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReturnRequestsScreen extends StatelessWidget {
  final controller = Get.put(ReturnController());

  ReturnRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchReturns(); // fetch on load

    return Scaffold(
      appBar: AppBar(title: const Text('Return Requests')),
      body: Obx(() {
        final returns = controller.returnRequests;

        if (returns.isEmpty) {
          return const Center(child: Text('No return requests found.'));
        }

        return ListView.builder(
          itemCount: returns.length,
          itemBuilder: (_, index) {
            final r = returns[index];
            return Card(
              child: ListTile(
                title: Text('${r.title}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${r.orderId}'),
                    Text('User: ${r.userId}'),
                    Text('Reason: ${r.reason}'),
                    Text('Status: ${r.status}'),
                    Text('Date: ${r.timestamp.toLocal()}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
