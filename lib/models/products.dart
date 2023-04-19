class Product {
  final int productId;
  final String brand;
  final int size;
  final String imageUrl;
  final int price;

  Product({
    required this.productId,
    required this.brand,
    required this.size,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      brand: json['brand'],
      size: json['size'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
