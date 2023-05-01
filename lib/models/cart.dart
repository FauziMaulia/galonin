class Cart {
  final int? cartId;
  final int userId;
  final int productId;
  final int amount;
  final String? brand;
  final int? size;
  final String? imageUrl;
  final int price;
  final String? nama;

  Cart({
    this.cartId,
    required this.userId,
    required this.productId,
    required this.amount,
    this.brand,
    this.size,
    this.imageUrl,
    required this.price,
    this.nama,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cart_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      amount: json['amount'],
      brand: json['brand'],
      size: json['size'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      nama: json['nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'user_id': userId,
      'product_id': productId,
      'amount': amount,
      'brand': brand,
      'size': size,
      'imageUrl': imageUrl,
      'price': price,
      'nama': nama,
    };
  }
}
