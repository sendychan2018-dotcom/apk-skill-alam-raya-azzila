import 'package:alam_raya_azzila/screens/login_page.dart';
import 'package:flutter/material.dart';

// Widget root aplikasi.
// MaterialApp adalah tempat utama untuk konfigurasi tema dan halaman awal.
class AlamRayaApp extends StatelessWidget {
  const AlamRayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alam Raya Azzila',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
