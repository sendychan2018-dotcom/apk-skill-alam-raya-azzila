import 'package:flutter/material.dart';

// Widget field input yang bisa dipakai berulang.
// Dengan cara ini, form login menjadi lebih rapi dan mudah dibaca.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF555555),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            prefixIcon: Icon(icon, color: Colors.black54),
            suffixIcon: onToggleVisibility == null
                ? null
                : IconButton(
                    onPressed: onToggleVisibility,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black54,
                    ),
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2E7D32)),
            ),
          ),
        ),
      ],
    );
  }
}
