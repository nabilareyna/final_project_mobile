class OrderModel {
  final String id;
  final String eventId;
  final String userId;
  final int qty;
  final int totalPrice;
  final String status;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.qty,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
    return OrderModel(
      id: id,
      eventId: json["eventId"],
      userId: json["userId"],
      qty: json["qty"],
      totalPrice: json["totalPrice"],
      status: json["status"],
      createdAt: json["createdAt"],
    );
  }
}
