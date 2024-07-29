import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/api/competition/post/register_comp_service.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/competition_task/comp_registration/comp_regis_mhs.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/models/auth/registration_model.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';

class RegisterCompetitionController {
  final RegisterCompetitionService _service = RegisterCompetitionService();
  RegistrationModel registrationModel = RegistrationModel();

  TextEditingController docs = TextEditingController();
  TextEditingController domicile = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController teamSize = TextEditingController();

  String? _selectedFilePath;

  void setFilePath(String filePath) {
    _selectedFilePath = filePath;
    debugPrint('Selected image path set: $_selectedFilePath');
  }

  void dispose() {
    docs.dispose();
    domicile.dispose();
    phoneNumber.dispose();
    teamSize.dispose();
    // Dispose other controllers
  }

  Future<void> register(BuildContext context, String competitionId, bool isTeam,
      int teamSize, List<TextEditingController> anggotaControllers) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String location = domicile.text.trim();
    String phone = phoneNumber.text.trim();
    String? supportingDocument = _selectedFilePath;

    List<String> teamMembers =
        anggotaControllers.map((controller) => controller.text.trim()).toList();

    try {
      bool loggedIn = await _service.registerCompetition(
        competitionId: competitionId,
        docs: supportingDocument,
        domicile: location,
        phoneNumber: phone,
        isTeam: isTeam,
        teamSize: teamSize,
        teamMembers: teamMembers,
      );
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (loggedIn) {
        // Navigate ke halaman setelah register sukses (contoh: EduPassApp)
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

      print('Error during register Competition: $e');
    }
  }
}
