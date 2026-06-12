// ignore_for_file: unreachable_switch_default

import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/features/shop/controller/customer/customer_controller.dart';
import 'package:admin/features/shop/controller/order/order_controller.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:admin/utils/helper/helper_function.dart';
import 'package:get/get.dart';

class DashboardController extends JBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  // Holds the sales data for each day (7 days of the week)
  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmount = <OrderStatus, double>{}.obs;

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  @override
  Future<List<OrderModel>> fetchItems() async {
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }
    if (customerController.allItems.isEmpty) {
      await customerController.fetchItems();
    }
    _calculateWeeklySales();

    _calculateOrderStatusData();
    return orderController.allItems;
  }

  void _calculateWeeklySales() {
    // Sample mock data for testing (You should calculate this based on your orders)
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orderController.allItems) {
      final DateTime orderWeekStart =
          JHelperFunction.getStartOfWeek(order.orderDate);
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();

    totalAmount.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      totalAmount[status] = (totalAmount[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {}
}
