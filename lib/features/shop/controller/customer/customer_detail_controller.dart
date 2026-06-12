import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/data/repositorries/address/address_repository.dart';
import 'package:admin/data/repositorries/user/user_repositories.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:admin/features/shop/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final serachTextController = TextEditingController();
  RxList<OrderModel> allCustomersOrders = <OrderModel>[].obs;
  RxList<OrderModel> fillteredCustomerOrders = <OrderModel>[].obs;

  Future<void> getCustomerOrderS() async {
    try {
      ordersLoading.value = true;

      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }
      allCustomersOrders.assignAll(customer.value.orders ?? []);
      fillteredCustomerOrders.assignAll(customer.value.orders ?? []);

      selectedRows.assignAll(List.generate(
          customer.value.orders != null ? customer.value.orders!.length : 0,
          (index) => false));
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  Future<void> getCustomerAddresses() async {
    try {
      addressesLoading.value = true;
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.address =
            await addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  void searchQuery(String query) {
    fillteredCustomerOrders.assignAll(
      allCustomersOrders.where((customer) =>
          customer.id.toLowerCase().contains(query.toLowerCase()) ||
          customer.orderDate.toString().contains(query.toLowerCase())),
    );
    update();
  }

  void sortById(int sortColumnIndex,bool ascending){
    sortAscending.value = ascending;
    fillteredCustomerOrders.sort((a,b){
      if(ascending){
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      }else{
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;
    update();
  }
}
