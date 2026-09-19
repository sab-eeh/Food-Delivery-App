import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<OrderModel>> getUserOrders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return [];

    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .get();

    return snapshot.docs.map((doc) {
      return OrderModel.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  Future<void> placeOrder({
    required String userId,
    required String userEmail,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
  }) async {
    await _firestore.collection('orders').add({
      'userId': userId,

      'userEmail': userEmail,

      'items': items,

      'totalPrice': totalPrice,

      'status': 'Pending',

      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
