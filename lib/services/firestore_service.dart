import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) return null;

      final doc = await _firestore.collection('users').doc(uid).get();

      return doc.data();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> saveUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,

      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
