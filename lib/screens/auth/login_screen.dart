import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_service.dart';
import '../../services/shared_pref_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../main_navigation_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final auth = AuthService();

    String? result = await auth.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (result == null) {
      await SharedPrefService.saveLogin(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 40),

                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.orange.shade100,
                    child: const Icon(
                      Icons.fastfood,
                      size: 50,
                      color: Colors.orange,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: Text(
                    "Foodie",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    "Delicious food delivered",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 50),

                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text("Login to continue"),

                const SizedBox(height: 25),

                CustomTextField(
                  hint: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  hint: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 30),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(text: "Login", onPressed: loginUser),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text("Create Account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
