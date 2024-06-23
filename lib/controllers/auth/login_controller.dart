import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginController {
  final AuthService _authService = AuthService(); // Instance dari AuthService

  // Controller untuk email dan password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Fungsi untuk melakukan login
  Future<void> login(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      bool loggedIn =
          await _authService.login(email: email, password: password);
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (loggedIn) {
        // Navigate ke halaman setelah login sukses (contoh: EduPassApp)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EduPassApp()));
        print('Login successful');
      } else {
        // Menampilkan pesan kesalahan jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login failed'),
          duration: Duration(seconds: 2),
        ));
        print('Login failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      print('Error during login: $e');
    }
  }
}
