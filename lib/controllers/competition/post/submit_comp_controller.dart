import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:edupass_mobile/api/competition/post/register_comp_service.dart';
import 'package:edupass_mobile/api/competition/post/submit_comp_service.dart';
import 'package:edupass_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';

class SubmitCommpController {
  final SubmitCompetitionService _submitCompetitionService =
      SubmitCompetitionService(); // Instance dari AuthService

  // Controller untuk input url
  TextEditingController urlController = TextEditingController();
  String? registrationId;

  // Fungsi untuk melakukan submit competition
  Future<void> submitCompetition(BuildContext context) async {
    // Tampilkan loading dialog
    DialogHelper.showLoading(context);

    final RegistrationIdManager regsitrationIdManager = RegistrationIdManager();
    registrationId = await regsitrationIdManager.getId();

    String password = urlController.text.trim();

    try {
      bool submitted = await _submitCompetitionService.submitCompetition(
          registrationId: registrationId!, url: password);
      // Sembunyikan loading dialog setelah selesai
      DialogHelper.hideLoading(context);

      if (submitted) {
        // Navigate ke halaman setelah submit competition sukses (contoh: EduPassApp)
        Navigator.pop(context);
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AwesomeSnackbarContent(
              titleFontSize: 17,
              messageFontSize: 15,
              title: 'Success!',
              message: 'Berhasil Mengumpulkan Tugas!',
              contentType: ContentType.success,
            ),
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        // Menampilkan pesan kesalahan jika submit competition gagal
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Submit Task failed'),
          duration: Duration(seconds: 2),
        ));
        debugPrint('Submit Task failed');
      }
    } catch (e) {
      // Sembunyikan loading dialog jika terjadi exception
      DialogHelper.hideLoading(context);

      // Tangani exception yang mungkin terjadi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ));

      debugPrint('Error during Submit Task: $e');
    }
  }
}
