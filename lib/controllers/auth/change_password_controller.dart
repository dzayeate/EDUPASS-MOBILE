import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordController {
  final AuthService _authService = AuthService(); // Instance dari AuthService

  // Controller untuk email dan password
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    // Dispose other controllers
  }

  // Fungsi untuk melakukan login
  Future<void> changePassword(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String oldPassword = oldPassController.text.trim();
    String newPassword = newPassController.text.trim();
    String confirmPassword = confirmPassController.text.trim();

    try {
      bool changedPass = await _authService.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword);
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (changedPass) {
        // Navigate ke halaman setelah login sukses (contoh: EduPassApp)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Change Password success'),
          duration: Duration(seconds: 2),
        ));
        print('Change Password successful');
      } else {
        // Menampilkan pesan kesalahan jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Change Password failed'),
          duration: Duration(seconds: 2),
        ));
        print('Change Password failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      print('Error during Change Password: $e');
    }
  }
}
