// Model data pengguna sederhana.
// File ini memisahkan data dari tampilan agar lebih rapi dan mudah dikembangkan.
class UserModel {
  final String username;
  final String role;

  const UserModel({
    required this.username,
    required this.role,
  });
}
