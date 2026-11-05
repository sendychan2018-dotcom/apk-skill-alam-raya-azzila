import 'package:alam_raya_azzila/models/user_model.dart';

// Service autentikasi.
// Kelas ini menangani validasi login supaya logic tidak tercampur dengan widget UI.
class AuthService {
  static bool validateCredentials(String username, String password) {
    final cleanUsername = username.trim();
    final cleanPassword = password.trim();

    if (cleanUsername.isEmpty || cleanPassword.isEmpty) {
      return false;
    }

    return cleanUsername.toLowerCase() == 'admin' && cleanPassword == '1234';
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

    return const UserModel(
      username: 'admin',
      role: 'Admin',
    );
  }
}
