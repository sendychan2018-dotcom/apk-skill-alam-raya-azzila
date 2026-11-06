import 'package:alam_raya_azzila/services/auth_service.dart';
import 'package:alam_raya_azzila/widgets/primary_button.dart';
import 'package:flutter/material.dart';

const _forest = Color(0xFF087445);

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    try {
      AuthService.register(
        fullName: _nameController.text,
        identifier: _identifierController.text,
        password: _passwordController.text,
      );
      Navigator.pop(context, _identifierController.text.trim());
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email atau nomor HP wajib diisi.';
    }
    final identifier = value.trim().toLowerCase();
    final isEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(identifier);
    final phoneDigits = identifier.replaceAll(RegExp(r'[\s()+-]'), '');
    final isPhone = RegExp(r'^\d{8,15}$').hasMatch(phoneDigits);
    if (!isEmail && !isPhone) {
      return 'Masukkan email atau nomor HP yang valid.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F8FB),
        foregroundColor: _forest,
        title: const Text(
          'Daftar Akun',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bergabung dengan Alam Raya Azzila',
                      style: TextStyle(
                        color: Color(0xFF1C2C34),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Lengkapi data untuk membuat akun pemain.',
                      style: TextStyle(
                        color: Color(0xFF70808A),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _RegistrationField(
                key: const Key('registration-name'),
                controller: _nameController,
                label: 'Nama lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person_outline_rounded,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama lengkap wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),
              _RegistrationField(
                key: const Key('registration-identifier'),
                controller: _identifierController,
                label: 'Email / No. HP',
                hint: 'contoh@email.com atau 08xxxxxxxxxx',
                icon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: _validateIdentifier,
              ),
              const SizedBox(height: 12),
              _RegistrationField(
                key: const Key('registration-password'),
                controller: _passwordController,
                label: 'Password',
                hint: 'Minimal 6 karakter',
                icon: Icons.lock_outline_rounded,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _isPasswordVisible = !_isPasswordVisible,
                  ),
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi.';
                  }
                  if (value.length < 6) return 'Password minimal 6 karakter.';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _RegistrationField(
                key: const Key('registration-confirm-password'),
                controller: _confirmPasswordController,
                label: 'Konfirmasi password',
                hint: 'Ulangi password',
                icon: Icons.lock_reset_rounded,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _isConfirmPasswordVisible =
                        !_isConfirmPasswordVisible,
                  ),
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password wajib diisi.';
                  }
                  if (value != _passwordController.text) {
                    return 'Konfirmasi password tidak sama.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PrimaryButton(text: 'DAFTAR SEKARANG', onPressed: _submit),
              const SizedBox(height: 12),
              const Text(
                'Akun demo hanya tersimpan selama aplikasi berjalan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF70808A), fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegistrationField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const _RegistrationField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF455A64),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            prefixIcon: Icon(icon, color: _forest),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFDCE4E9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Color(0xFFDCE4E9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: _forest),
            ),
          ),
        ),
      ],
    );
  }
}
