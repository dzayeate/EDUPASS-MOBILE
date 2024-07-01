import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/models/auth/update_user_model.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';

class UpdateUserController {
  final AuthService _authService = AuthService();
  UpdateUserModel updateUserModel = UpdateUserModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController regenciesController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController proofController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    phoneController.dispose();
    addressController.dispose();
    provinceController.dispose();
    regenciesController.dispose();
    addressController.dispose();
    imageController.dispose();
    institutionNameController.dispose();
    studyFieldController.dispose();
    uniqueIdController.dispose();
    proofController.dispose();
    // Dispose other controllers
  }

  Future<void> updateBio(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String birthDate = birthDateController.text.trim();
    String gender = genderController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    String province = provinceController.text.trim();
    String regencies = regenciesController.text.trim();
    String institutionName = institutionNameController.text.trim();
    String image = imageController.text.trim();
    String studyField = studyFieldController.text.trim();
    String uniqueId = uniqueIdController.text.trim();
    String proof = proofController.text.trim();

    try {
      bool bioUpdated = await _authService.updateBio(
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
        field: studyField,
        pupils: uniqueId,
        proof: proof,
      );
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (bioUpdated) {
        // Navigate ke halaman setelah UpdateBio sukses (contoh: EduPassApp)
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EduPassApp(
                      initialPageIndex: 4,
                    )));
        debugPrint('UpdateBio successful');
      } else {
        // Menampilkan pesan kesalahan jika UpdateBio gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('UpdateBio failed'),
          duration: Duration(seconds: 2),
        ));
        debugPrint('UpdateBio failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      debugPrint('Error during UpdateBio: $e');
    }
  }
}
