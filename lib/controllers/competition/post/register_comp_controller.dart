import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:edupass_mobile/api/competition/post/register_comp_service.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:edupass_mobile/models/auth/registration_model.dart';
import 'package:flutter/material.dart';

class RegisterCompetitionController {
  final RegisterCompetitionService _service = RegisterCompetitionService();
  RegistrationModel registrationModel = RegistrationModel();

  TextEditingController docs = TextEditingController();
  TextEditingController domicile = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController teamSize = TextEditingController();
  TextEditingController nameTeam = TextEditingController();

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
    nameTeam.dispose();
    // Dispose other controllers
  }

  Future<void> register(BuildContext context, String competitionId, bool isTeam,
      int teamSize, List<TextEditingController> anggotaControllers) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    String location = domicile.text.trim();
    String phone = phoneNumber.text.trim();
    String teamName = isTeam ? nameTeam.text.trim() : "";
    String? supportingDocument = _selectedFilePath;

    List<String> teamMembers =
        anggotaControllers.map((controller) => controller.text.trim()).toList();

    try {
      bool registeredComp = await _service.registerCompetition(
        competitionId: competitionId,
        docs: supportingDocument,
        domicile: location,
        phoneNumber: phone,
        isTeam: isTeam,
        teamName: teamName,
        teamSize: teamSize,
        teamMembers: teamMembers,
      );
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (registeredComp) {
        // Navigate ke halaman setelah register sukses (contoh: EduPassApp)
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: AwesomeSnackbarContent(
              titleFontSize: 17,
              messageFontSize: 15,
              title: 'Succsess!',
              message: 'Register Kompetisi Berhasil!',
              contentType: ContentType.success,
            ),
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        debugPrint('register successful');
      } else {
        // Menampilkan pesan kesalahan jika register gagal
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: AwesomeSnackbarContent(
              titleFontSize: 17,
              messageFontSize: 15,
              title: 'Oh Snap!',
              message: 'Register Kompetisi Gagal!',
              contentType: ContentType.failure,
            ),
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        debugPrint('register failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: AwesomeSnackbarContent(
            titleFontSize: 17,
            messageFontSize: 15,
            title: 'Oh Snap!',
            message: '$e',
            contentType: ContentType.failure,
          ),
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      debugPrint('Error during register Competition: $e');
    }
  }
}
