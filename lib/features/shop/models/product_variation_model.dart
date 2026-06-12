import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description; // Corrected spelling to 'description'
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
   String image = '',
    this.description = '',
    this.soldQuantity = 0,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  }):image = image.obs;

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  toJson() {
    return {
      'id': id,
      'sku': sku,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'soldQuantity':soldQuantity,
      'attributeValues': attributeValues,
    };
  }
    factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
      final data = document;
      if(data.isEmpty)return ProductVariationModel.empty();
      return ProductVariationModel(id: data['id'] ?? '',
      price: double.parse((data['price']?? 0.0).toString()),
      sku: data['sku'] ?? '',
      stock:  data['stock'] ?? 0,
      soldQuantity: data['soldQuantity']?? 0,
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
       image: data['image'] ?? '',
       attributeValues: Map<String, String>.from(data['attributeValues'])
       );
    }
}