import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_model.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FoodModel>> getFoods() async {
    try {
      final snapshot = await _firestore.collection('foods').get();

      return snapshot.docs.map((doc) {
        return FoodModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load foods: $e');
    }
  }
}
