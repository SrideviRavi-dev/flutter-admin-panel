// ignore_for_file: unused_local_variable, avoid_print

import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/data/repositorries/category_repository/category_repository.dart';
import 'package:admin/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends JBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containsSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

   void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (CategoryModel category)=> category.name.toLowerCase());
   }

}

