// ignore_for_file: avoid_print

import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/data/repositorries/order/order_repository.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:get/get.dart';

class OrderController extends JBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());
  var items = <OrderModel>[].obs;

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    final orders = await _orderRepository.getAllOrder();
    print("Fetched Orders: ${orders.length}"); // Debugging
    return orders;
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (OrderModel o) => o.orderDate.toString().toLowerCase());
  }

  Future<void> updateOrderStatus(
      OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository
          .updateOrderSpecificValues(order.docId, {'status': newStatus.name});

      updateItemFromLists(order);
      orderStatus.value = newStatus;
      JLoaders.successSnackBar(
          title: 'Updated', message: 'Order status Updated');
    } catch (e) {
      JLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}
