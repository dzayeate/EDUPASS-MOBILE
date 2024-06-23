import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordController {
  final AuthService _authService = AuthService(); // Instance dari AuthService

  // Controller untuk email dan password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Fungsi untuk melakukan login
  Future<void> forgetPassword(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String email = emailController.text.trim();

    try {
      bool forgetSuccess = await _authService.forgetPassword(email: email);
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (forgetSuccess) {
        // Navigate ke halaman setelah send email sukses (contoh: EduPassApp)
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        debugPrint('Email send successful');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email send successful : Please Check Your Email'),
          duration: Duration(seconds: 2),
        ));
      } else {
        // Menampilkan pesan kesalahan jika send email gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email Send failed'),
          duration: Duration(seconds: 2),
        ));
        debugPrint('Send Email failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      debugPrint('Error during Send Email: $e');
    }
  }
}
