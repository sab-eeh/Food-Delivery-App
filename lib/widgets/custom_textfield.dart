import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: const Color(0xFFF3F3F3),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
