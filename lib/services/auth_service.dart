import 'package:alam_raya_azzila/models/user_model.dart';

// Service autentikasi.
// Kelas ini menangani validasi login supaya logic tidak tercampur dengan widget UI.
class AuthService {
  static final Map<String, _RegisteredAccount> _registeredAccounts = {};

  static bool validateCredentials(String username, String password) {
    final cleanUsername = username.trim();
    final cleanPassword = password.trim();

    if (cleanUsername.isEmpty || cleanPassword.isEmpty) {
      return false;
    }

    if (cleanUsername.toLowerCase() == 'admin' && cleanPassword == '1234') {
      return true;
    }

    return _registeredAccounts[cleanUsername.toLowerCase()]?.password ==
        cleanPassword;
  }

  static UserModel login(String username, String password) {
    final cleanUsername = username.trim();
    final cleanPassword = password.trim();

    if (cleanUsername.isEmpty || cleanPassword.isEmpty) {
      throw Exception('Username dan password wajib diisi.');
    }

    if (!validateCredentials(cleanUsername, cleanPassword)) {
      throw Exception('Username atau password salah.');
    }

    final account = _registeredAccounts[cleanUsername.toLowerCase()];
    if (account != null) return account.user;

    return const UserModel(
      username: 'admin',
      role: 'Admin',
    );
  }

  static void register({
    required String fullName,
    required String identifier,
    required String password,
  }) {
    final cleanName = fullName.trim();
    final cleanIdentifier = identifier.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanName.isEmpty || cleanIdentifier.isEmpty || cleanPassword.isEmpty) {
      throw Exception('Semua data pendaftaran wajib diisi.');
    }

    if (!_isValidEmailOrPhone(cleanIdentifier)) {
      throw Exception('Masukkan email atau nomor HP yang valid.');
    }

    if (cleanPassword.length < 6) {
      throw Exception('Password minimal 6 karakter.');
    }

    if (cleanIdentifier == 'admin' ||
        _registeredAccounts.containsKey(cleanIdentifier)) {
      throw Exception('Email atau nomor HP sudah terdaftar.');
    }

    _registeredAccounts[cleanIdentifier] = _RegisteredAccount(
      user: UserModel(username: cleanName, role: 'Pemain'),
      password: cleanPassword,
    );
  }

  static bool _isValidEmailOrPhone(String identifier) {
    final isEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(identifier);
    final phoneDigits = identifier.replaceAll(RegExp(r'[\s()+-]'), '');
    final isPhone = RegExp(r'^\d{8,15}$').hasMatch(phoneDigits);
    return isEmail || isPhone;
  }
}

class _RegisteredAccount {
  final UserModel user;
  final String password;

  const _RegisteredAccount({required this.user, required this.password});
}
