// ignore_for_file: avoid_print

import 'package:admin/common/widgets/loader/full_screen_loadder.dart';
import 'package:admin/common/widgets/loader/loaders.dart';
import 'package:admin/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class JBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<List<T>> fetchItems();
  Future<void> deleteItem(T item);
  bool containsSearchQuery(T item, String query);

  Future<void> fetchData() async {
    try {
      isLoading.value = true;

      List<T> fetechedItems = [];

      if (allItems.isEmpty) {
        fetechedItems = await fetchItems();
      }
     
      allItems.assignAll(fetechedItems);
      filteredItems.assignAll(allItems);

      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      JLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );
  }

  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  confirmAndDeleteItem(T category) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(category),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: JSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(JSizes.buttonRadius * 5)),
            ),
            child: const Text('Ok')),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: JSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(JSizes.buttonRadius * 5)),
            ),
            child: const Text('Cancel')),
      ),
    );
  }

  deleteOnConfirm(T item) async {
    try {
      JFullScreenLoader.stopLoading();
      JFullScreenLoader.popUpCircular();
      await deleteItem(item);
      removeItemFromLists(item);
      JFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been Deleted');
    } catch (e) {
      JFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    update();
  }

  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;

    filteredItems.refresh();
  }
}
