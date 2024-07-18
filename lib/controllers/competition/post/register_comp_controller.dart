import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/api/competition/post/register_comp_service.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/models/auth/registration_model.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';

class RegisterCompetitionController {
  final RegisterCompetitionService _registerCompetitionService =
      RegisterCompetitionService();
  RegistrationModel registrationModel = RegistrationModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController institutionLevelController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController regenciesController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    uniqueIdController.dispose();
    institutionNameController.dispose();
    institutionLevelController.dispose();
    provinceController.dispose();
    regenciesController.dispose();
    studyFieldController.dispose();
    // Dispose other controllers
  }

  void addFirstStepData({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    registrationModel.email = emailController.text.trim();
    registrationModel.password = passwordController.text.trim();
    registrationModel.confirmPassword = confirmPasswordController.text.trim();
  }

  Future<void> register(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = passwordController.text.trim();
    String firstName = "";
    String lastName = "";
    String birthDate = "";
    String gender = "";
    String phone = "";
    String address = "";
    String province = "";
    String regencies = "";
    String institutionName = "";
    String image = "";
    String field = "";
    String pupils = "";
    String proof = "";

    try {
      bool loggedIn = await _registerCompetitionService.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        gender: gender,
        phone: phone,
        address: address,
        province: province,
        regencies: regencies,
        institutionName: institutionName,
        image: image,
        field: field,
        pupils: pupils,
        proof: proof,
      );
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (loggedIn) {
        // Navigate ke halaman setelah register sukses (contoh: EduPassApp)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EduPassApp()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Register Successful'),
          duration: Duration(seconds: 2),
        ));
        print('register successful');
      } else {
        // Menampilkan pesan kesalahan jika register gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('register failed'),
          duration: Duration(seconds: 2),
        ));
        print('register failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      print('Error during register: $e');
    }
  }
}
