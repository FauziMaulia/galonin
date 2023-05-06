class Order {
  int? orderId;
  int userId;
  int totalPay;
  String? status;
  List? orderItems;

  Order({this.orderId, required this.userId, required this.totalPay, this.status,this.orderItems});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      userId: json['user_id'],
      totalPay: json['total_pay'],
      status: json['status'],
      orderItems: json['order_items']
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'total_pay': totalPay,
      'status': status,
      'order_items': orderItems,
    };
  }
}
