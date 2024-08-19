import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/settings/setting_screen.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChangeRoleController {
  final AuthService _authService = AuthService();

  TextEditingController roleNameController = TextEditingController();

  void dispose() {
    roleNameController.dispose();
  }

  Future<void> changeRole(BuildContext context) async {
    DialogHelper.showLoading(context);
    String roleName = roleNameController.text.trim();

    try {
      bool changedRole = await _authService.changeRole(
        roleName: roleName,
      );
      DialogHelper.hideLoading(context);

      if (changedRole) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Role berhasil diubah'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gagal mengubah role'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      DialogHelper.hideLoading(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
