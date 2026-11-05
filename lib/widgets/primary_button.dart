import 'package:flutter/material.dart';

// Tombol utama reusable.
// Widget ini memudahkan penggunaan tombol dengan gaya yang konsisten di seluruh app.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2FAE66),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
