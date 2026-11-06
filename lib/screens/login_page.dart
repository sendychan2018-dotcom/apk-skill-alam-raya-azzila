import 'package:alam_raya_azzila/screens/home_page.dart';
import 'package:alam_raya_azzila/screens/registration_page.dart';
import 'package:alam_raya_azzila/services/auth_service.dart';
import 'package:alam_raya_azzila/widgets/custom_text_field.dart';
import 'package:alam_raya_azzila/widgets/primary_button.dart';
import 'package:flutter/material.dart';

const _forest = Color(0xFF087445);

class LoginPage extends StatefulWidget {
  final String initialUsername;

  const LoginPage({super.key, this.initialUsername = ''});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.initialUsername;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    try {
      final user = AuthService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(user: user)),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }

  Future<void> _openRegistration() async {
    final identifier = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const RegistrationPage()),
    );
    if (!mounted || identifier == null) return;

    _usernameController.text = identifier;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pendaftaran berhasil. Silakan masuk dengan akun baru.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    _LoginHeader(height: constraints.maxHeight * 0.32),
                    Transform.translate(
                      offset: const Offset(0, -22),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 430),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 17),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF123D2B,
                              ).withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C2C34),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Masuk ke akun Anda',
                              style: TextStyle(
                                color: Color(0xFF70808A),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 18),
                            CustomTextField(
                              controller: _usernameController,
                              label: 'Email / No. HP',
                              hintText: 'Masukkan username',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 13),
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Password',
                              hintText: 'Masukkan password',
                              icon: Icons.lock_outline_rounded,
                              obscureText: !_isPasswordVisible,
                              onToggleVisibility: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    activeColor: _forest,
                                    visualDensity: VisualDensity.compact,
                                    onChanged: (value) => setState(
                                      () => _rememberMe = value ?? false,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Ingat saya',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF52616A),
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Hubungi admin untuk bantuan password.',
                                          ),
                                        ),
                                      ),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Lupa password?',
                                    style: TextStyle(
                                      color: _forest,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            PrimaryButton(text: 'LOGIN', onPressed: _login),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              child: Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'atau',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF71818A),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 42,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Text(
                                  'G',
                                  style: TextStyle(
                                    color: Color(0xFF4285F4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                label: const Text(
                                  'Masuk dengan Google',
                                  style: TextStyle(
                                    color: Color(0xFF33434C),
                                    fontSize: 12,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFDCE4E9),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Belum punya akun?',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF687880),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _openRegistration,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Daftar',
                                    style: TextStyle(
                                      color: _forest,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  final double height;

  const _LoginHeader({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.clamp(205.0, 280.0).toDouble(),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D8653), Color(0xFF075536)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(42)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 98,
            height: 98,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white70, width: 1.5),
            ),
            child: Image.asset('img/LOGO AZZILA.png', fit: BoxFit.contain),
          ),
          const SizedBox(height: 11),
          const Text(
            'SSB ALAM RAYA AZZILA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Bersama Membangun Generasi Sepak Bola',
            style: TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
