import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/data/repositorries/banner_repository/banner_repository.dart';
import 'package:admin/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends JBaseController<BannerModel> {
  static BannerController get instance => Get.find();
  final _bannerRepository = Get.put(BannerRepository());

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
Future<List<BannerModel>> fetchItems() async {
  var banners = await _bannerRepository.getAllBanners();
  return banners;
}

  String formatRoute(String route) {
    if (route.isEmpty) return '';

    String formatted = route.substring(1);

    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }
}
