import 'package:edupass_mobile/controllers/auth/change_password_controller.dart';
import 'package:edupass_mobile/screens/components/custom_form_field.dart';
import 'package:edupass_mobile/screens/profile/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController _changePassController =
      ChangePasswordController();

  @override
  void dispose() {
    _changePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingScreen(),
              ),
            );
          },
        ),
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomFormField(
                controller: _changePassController.oldPassController,
                labelText: 'Old Password',
                isPassword: true,
                validator: passwordValidator,
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: _changePassController.newPassController,
                labelText: 'New Password',
                isPassword: true,
                validator: passwordValidator,
              ),
              const SizedBox(height: 20),
              CustomFormField(
                controller: _changePassController.confirmPassController,
                labelText: 'Confirm Password',
                isPassword: true,
                validator: (value) => confirmPasswordValidator(
                    value, _changePassController.newPassController.text),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final oldPassError = passwordValidator(
                      _changePassController.oldPassController.text);
                  final newPasswordError = passwordValidator(
                      _changePassController.newPassController.text);
                  final confirmPasswordError = confirmPasswordValidator(
                      _changePassController.confirmPassController.text,
                      _changePassController.confirmPassController.text);

                  if (oldPassError == null &&
                      newPasswordError == null &&
                      confirmPasswordError == null) {
                    _changePassController.changePassword(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Change Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
