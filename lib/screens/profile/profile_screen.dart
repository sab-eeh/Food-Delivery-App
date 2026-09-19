import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firestore_service.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import '../orders/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await FirestoreService().getCurrentUserData();

    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  Future<void> logout() async {
    await AuthService().logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 20),

            Text(
              userData?['name'] ?? 'User',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            Text(
              userData?['email'] ??
                  FirebaseAuth.instance.currentUser?.email ??
                  '',
            ),

            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.shopping_bag),

              title: const Text("My Orders"),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrdersScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),

              title: const Text("Logout"),

              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}
