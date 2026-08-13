import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WishTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color iconBgColor;
  final String? hintText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const WishTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.iconBgColor,
    this.hintText,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black87,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white60 : Colors.black54,
          fontSize: 14,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: iconBgColor,
            child: Icon(icon, color: const Color(0xFF6d66b1), size: 18),
          ),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}