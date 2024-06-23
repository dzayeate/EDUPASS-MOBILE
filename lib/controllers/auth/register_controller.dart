import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/models/auth/registration_model.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final AuthService _authService = AuthService();
  RegistrationModel registrationModel = RegistrationModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController roleNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController institutionLevelController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController regenciesController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    roleNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    nikController.dispose();
    institutionNameController.dispose();
    institutionLevelController.dispose();
    provinceController.dispose();
    regenciesController.dispose();
    studyFieldController.dispose();
    reasonController.dispose();
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
      bool loggedIn = await _authService.register(
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
  // void addSecondStepData({
  //   required String roleName,
  // }) {
  //   registrationModel.roleName = roleNameController.text.trim();
  // }

  // void addThirdStepData({
  //   required String firstName,
  //   required String lastName,
  //   required String nik,
  //   required String institutionName,
  //   required String institutionLevel,
  //   required String province,
  //   required String regencies,
  //   required String studyField,
  //   required String reason,
  //   required String image,
  // }) {
  //   registrationModel.firstName = firstNameController.text.trim();
  //   registrationModel.lastName = lastNameController.text.trim();
  //   registrationModel.nik = nikController.text.trim();
  //   registrationModel.institutionName = institutionNameController.text.trim();
  //   registrationModel.institutionLevel = institutionLevelController.text.trim();
  //   registrationModel.province = provinceController.text.trim();
  //   registrationModel.regencies = regenciesController.text.trim();
  //   registrationModel.studyField = studyFieldController.text.trim();
  //   registrationModel.reason = reasonController.text.trim();
  //   registrationModel.image = image;
  // }

//   Future<void> register(BuildContext context) async {
//     DialogHelper.showLoading(context);

//     try {
//       bool registered = await _authService.register(
//         email: registrationModel.email,
//         password: registrationModel.password,
//         confirmPassword: registrationModel.confirmPassword,
//         firstName: registrationModel.firstName,
//         lastName: registrationModel.lastName,
//         birthDate: registrationModel.birthDate,
//         gender: registrationModel.gender,
//         phone: registrationModel.phone,
//         address: registrationModel.address,
//         province: registrationModel.province,
//         regencies: registrationModel.regencies,
//         institutionName: registrationModel.institutionName,
//         image: registrationModel.image,
//         field: registrationModel.field,
//         pupils: registrationModel.pupils,
//         proof: registrationModel.proof,
//       );

//       // bool registered = await _authService.register(
//       //   email: registrationModel.email,
//       //   password: registrationModel.password,
//       //   confirmPassword: registrationModel.confirmPassword,
//       //   roleName: registrationModel.roleName,
//       //   firstName: registrationModel.firstName,
//       //   lastName: registrationModel.lastName,
//       //   nik: registrationModel.nik,
//       //   institutionName: registrationModel.institutionName,
//       //   institutionLevel: registrationModel.institutionLevel,
//       //   province: registrationModel.province,
//       //   regencies: registrationModel.regencies,
//       //   studyField: registrationModel.studyField,
//       //   reason: registrationModel.reason,
//       //   image: registrationModel.image,
//       // );

//       DialogHelper.hideLoading(context);

//       if (registered) {
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => EduPassApp()));
//         print('Register successful');
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('register failed'),
//           duration: Duration(seconds: 2),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Registrasi gagal'),
//           duration: Duration(seconds: 2),
//         ));
//         print('Registrasi gagal');
//       }
//     } catch (e) {
//       DialogHelper.hideLoading(context);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error: $e'),
//         duration: const Duration(seconds: 2),
//       ));

//       print('Error saat registrasi: $e');
//     }
//   }

