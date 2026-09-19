class OrderModel {
  final String id;
  final String userEmail;
  final double totalPrice;
  final String status;

  OrderModel({
    required this.id,
    required this.userEmail,
    required this.totalPrice,
    required this.status,
  });

  factory OrderModel.fromFirestore(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      userEmail: data['userEmail'] ?? '',
      totalPrice: (data['totalPrice'] as num).toDouble(),
      status: data['status'] ?? '',
    );
  }
}
