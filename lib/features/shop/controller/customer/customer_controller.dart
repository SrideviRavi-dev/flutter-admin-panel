import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/data/repositorries/user/user_repositories.dart';
import 'package:admin/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends JBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customerRepository.getAllUsers();
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customerRepository.deleteUser(item.id ?? '');
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (UserModel o) => o.fullName.toString().toLowerCase());
  }
}
