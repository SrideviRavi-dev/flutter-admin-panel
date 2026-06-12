class CartItemModel {
  String productId;
  String title;
  double price;
  double salePrice;
  String? imageUrls;
  int quantity;
  String variationId;
  Map<String, String>? selectedVariation;
  String? selectedSize;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.imageUrls,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.title = '',
    this.selectedVariation,
    this.selectedSize,
  });

  String get totalAmount =>
      ((salePrice > 0 ? salePrice : price) * quantity).toStringAsFixed(1);

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId.isNotEmpty ? productId : null,
      'title': title,
      'imageUrls': imageUrls ?? '',
      'price': price,
      'salePrice': salePrice,
      'quantity': quantity,
      'selectedVariation': selectedVariation ?? {},
      'variationId': variationId,
      'selectedSize': selectedSize,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? 'Unknown',
      imageUrls: json['imageUrls'] is List
          ? (json['imageUrls'].isNotEmpty
              ? json['imageUrls'][0] as String
              : null)
          : json['imageUrls'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
      selectedVariation: json['selectedVariation'] is Map
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
      variationId: json['variationId'] ?? '',
      selectedSize: json['selectedSize'],
    );
  }
}
