import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import '../../services/shared_pref_service.dart';
import '../main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await SharedPrefService.getLoginStatus();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.fastfood, size: 100),

            SizedBox(height: 20),

            Text(
              'Foodie',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
