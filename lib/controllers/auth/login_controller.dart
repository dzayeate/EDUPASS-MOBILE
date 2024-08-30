import 'package:edupass_mobile/screens/components/custom_form_field.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoginController {
  final AuthService _authService = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context, bool showErrors) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    String? emailError = emailValidator(email);
    String? passwordError = passwordValidator(password);

    if (emailError != null || passwordError != null && showErrors) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(emailError ?? passwordError!),
        duration: const Duration(seconds: 2),
      ));
      return;
    }

    DialogHelper.showLoading(context);

    try {
      bool loggedIn =
          await _authService.login(email: email, password: password);

      DialogHelper.hideLoading(context);

      if (loggedIn) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EduPassApp()));
        debugPrint('Login successful');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login failed'),
          duration: Duration(seconds: 2),
        ));
        debugPrint('Login failed');
      }
    } catch (e) {
      DialogHelper.hideLoading(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      debugPrint('Error during login: $e');
    }
  }
}
