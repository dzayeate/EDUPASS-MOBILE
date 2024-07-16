import 'dart:io';

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
  TextEditingController institutionNameController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController proofController = TextEditingController();

  String? _selectedImagePath;
  String? _selectedProofPath;

  void setImagePath(String filePath) {
    _selectedImagePath = filePath;
    debugPrint('Selected image path set: $_selectedImagePath');
  }

  void setProofPath(String filePath) {
    _selectedProofPath = filePath;
    debugPrint('Selected proof path set: $_selectedProofPath');
  }

  void reset() {
    _selectedImagePath = null;
    _selectedProofPath = null;
    firstNameController.clear();
    lastNameController.clear();
    birthDateController.clear();
    genderController.clear();
    phoneController.clear();
    addressController.clear();
    provinceController.clear();
    regenciesController.clear();
    institutionNameController.clear();
    studyFieldController.clear();
    uniqueIdController.clear();
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    phoneController.dispose();
    addressController.dispose();
    provinceController.dispose();
    regenciesController.dispose();
    institutionNameController.dispose();
    studyFieldController.dispose();
    uniqueIdController.dispose();
  }

  bool fileExists(String path) {
    return File(path).existsSync();
  }

  Future<void> updateBio(BuildContext context) async {
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
    String studyField = studyFieldController.text.trim();
    String uniqueId = uniqueIdController.text.trim();
    // String? image = imageController.text.trim();
    // String? proof = proofController.text.trim();
    String? image = _selectedImagePath;
    String? proof = _selectedProofPath;

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
        field: studyField,
        pupils: uniqueId,
        image: image,
        proof: proof,
      );
      DialogHelper.hideLoading(context);

      if (bioUpdated) {
        reset();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EduPassApp(
                      initialPageIndex: 4,
                    )));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('UpdateBio berhasil'),
          duration: Duration(seconds: 1),
        ));
        debugPrint('UpdateBio berhasil');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('UpdateBio gagal'),
          duration: Duration(seconds: 2),
        ));
        debugPrint('UpdateBio gagal');
      }
    } catch (e) {
      DialogHelper.hideLoading(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));
      debugPrint('Error saat UpdateBio: $e');
    }
  }
}
