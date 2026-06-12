// ignore_for_file: avoid_print, annotate_overrides, avoid_renaming_method_parameters

import 'package:admin/data/abstract/base_data_table_controller.dart';
import 'package:admin/data/repositorries/product_repository/product_repository.dart';
import 'package:admin/features/shop/models/product_model.dart';
import 'package:admin/utils/constants/enum.dart';
import 'package:get/get.dart';

class ProductController extends JBaseController<ProductsModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());
  var categoryProducts = <ProductsModel>[].obs;

  @override
  Future<List<ProductsModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductsModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductsModel item) async {
    await _productRepository.deleteProduct(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductsModel product) => product.title.toLowerCase());
  }

  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductsModel product) => product.price);
  }

  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductsModel product) => product.stock);
  }

  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductsModel product) => product.soldQuantity);
  }

  String getProductPrice(ProductsModel product) {
    // Ensure productVariations is not null before checking isEmpty
    if (product.productType == ProductType.single.toString() ||
        (product.productVariations?.isEmpty ?? true)) {
      double salePrice = product.salePrice ?? 0.0; // Default to 0 if null
      double price = product.price ?? 0.0; // Default to 0 if null
      return (salePrice > 0.0 ? salePrice : price).toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      for (var variation in product.productVariations ?? []) {
        double salePrice = variation.salePrice ?? 0.0; // Handle null
        double price = variation.price ?? 0.0; // Handle null

        double priceToConsider = salePrice > 0.0 ? salePrice : price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          // Fix: use ">" for largestPrice
          largestPrice = priceToConsider;
        }
      }

      // Fix: Compare values using ==
      if (smallestPrice == largestPrice) {
        return largestPrice.toString();
      } else {
        return '\$$smallestPrice - \$$largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockTotal(ProductsModel product) {
    if (product.productType == ProductType.single.name) {
      return product.stock.toString();
    } else {
      // Ensure productVariations is not null before folding
      int totalStock = product.productVariations?.fold<int>(
            0,
            (previousValue, element) => previousValue + (element.stock ?? 0),
          ) ??
          0;
      return totalStock.toString();
    }
  }

  String getProductSoldQuantity(ProductsModel product) {
    if (product.productType == ProductType.single.name) {
      return product.soldQuantity?.toString() ?? "0";  
    } else {
      int totalSold = product.productVariations?.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.soldQuantity ?? 0),
          ) ??
          0;
      return totalSold.toString();
    }
  }

  String getProductsStockStatus(ProductsModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final products =
          await ProductRepository.instance.getProductsByCategory(categoryId);
      categoryProducts.assignAll(products);
    } catch (e) {
      print("❌ Error: $e");
    }
  }

  Future<void> refreshCategoryProducts(Set<String> categoryIds) async {
    final List<ProductsModel> allProducts = [];

    for (String categoryId in categoryIds) {
      final products =
          await ProductRepository.instance.getProductsByCategory(categoryId);
      allProducts.addAll(products);
    }

    categoryProducts.assignAll(allProducts); // ✅ This will notify Obx UI
  }

  void updateItemFromLists(ProductsModel updatedProduct) {
    final index = allItems.indexWhere((item) => item.id == updatedProduct.id);
    if (index != -1) {
      allItems[index] = updatedProduct;
      allItems.refresh();
    }

    final categoryIndex =
        categoryProducts.indexWhere((item) => item.id == updatedProduct.id);
    if (categoryIndex != -1) {
      categoryProducts[categoryIndex] = updatedProduct;
      categoryProducts.refresh();
    }
  }
}
