import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../services/firestore_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> signupUser() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));

      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));

      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final auth = AuthService();

      UserCredential? credential = await auth.signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (credential != null) {
        await FirestoreService().saveUser(
          uid: credential.user!.uid,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Created Successfully")),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signup Failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 20),

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(height: 10),

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
                    "Create your account",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 40),

                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Join Foodie today",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),

                const SizedBox(height: 25),

                CustomTextField(
                  hint: "Full Name",
                  icon: Icons.person,
                  controller: nameController,
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                CustomTextField(
                  hint: "Confirm Password",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  controller: confirmPasswordController,
                ),

                const SizedBox(height: 30),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "Create Account",
                        onPressed: signupUser,
                      ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text("Already have an account?"),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
