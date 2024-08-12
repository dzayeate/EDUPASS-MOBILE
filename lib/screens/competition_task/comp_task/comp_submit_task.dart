import 'package:edupass_mobile/controllers/competition/post/submit_comp_controller.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitCompetitionTask extends StatefulWidget {
  const SubmitCompetitionTask({super.key});

  @override
  State<SubmitCompetitionTask> createState() => _SubmitCompetitionTaskState();
}

class _SubmitCompetitionTaskState extends State<SubmitCompetitionTask> {
  final SubmitCommpController submitCompetitionController =
      SubmitCommpController();

  bool isInfoChecked = false;
  bool isAgreeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Tambahkan navigasi kembali
          },
        ),
        title: Text(
          "Pengumpulan Task",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'NSPACE 2024 : UI/UX COMPETITION',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Competition description. Forem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 36),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Time, date - Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Complete the registration form below',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              labelText: 'Link Figma / Github ',
              hintText: 'http://figma.com',
              readOnly: false,
              controller: submitCompetitionController.urlController,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                submitCompetitionController.submitCompetition(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Kirim',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
