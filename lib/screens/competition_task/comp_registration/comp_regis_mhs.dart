import 'package:edupass_mobile/controllers/competition/post/register_comp_controller.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/components/upload_file_field.dart';
import 'package:edupass_mobile/screens/profile/components/upload_image_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompetitionMhsRegis extends StatefulWidget {
  final String id;
  const CompetitionMhsRegis({super.key, required this.id});

  @override
  State<CompetitionMhsRegis> createState() => _CompetitionMhsRegisState();
}

class _CompetitionMhsRegisState extends State<CompetitionMhsRegis> {
  final RegisterCompetitionController controller =
      RegisterCompetitionController();
  String? _selectedFilePath;
  bool isInfoChecked = false;
  bool isAgreeChecked = false;
  bool isTeam = false;
  List<Widget> anggotaFields = [];
  List<TextEditingController> anggotaControllers = [];

  void _handleFileSelected(String filePath) {
    setState(() {
      _selectedFilePath = filePath;
      // update controller
      controller.setFilePath(filePath);
    });
    debugPrint('File path: $filePath');
  }

  void _addAnggotaField() {
    TextEditingController newController = TextEditingController();
    anggotaControllers.add(newController);
    anggotaFields.add(
      Column(
        children: [
          const SizedBox(height: 16),
          CustomTextField(
            labelText: 'Nama Anggota',
            hintText: 'Nama Anggota',
            readOnly: false,
            controller: newController,
          ),
        ],
      ),
    );
  }

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
          "Pendaftaran Event",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Title Competition',
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
              labelText: 'Asal Lokasi',
              hintText: 'Bandung',
              readOnly: false,
              controller: controller.domicile,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Nomor Handphone',
              hintText: 'Masukkan Nomor',
              readOnly: false,
              controller: controller.phoneNumber,
            ),
            const SizedBox(height: 30),
            UploadFileField(onFileSelected: _handleFileSelected),
            const SizedBox(height: 24),
            if (_selectedFilePath != null) ...[
              Text('Selected file: $_selectedFilePath'),
            ],
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Nama Tim',
              hintText: 'Masukkan Nama Tim',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Registrasi sebagai tim'),
                Checkbox(
                  value: isTeam,
                  onChanged: (bool? value) {
                    setState(() {
                      isTeam = value ?? false;
                    });
                  },
                ),
              ],
            ),
            if (isTeam) ...[
              CustomTextField(
                labelText: 'Jumlah Anggota',
                hintText: 'Jumlah Anggota',
                readOnly: false,
                controller: controller.teamSize,
              ),
              const SizedBox(height: 16),
              Column(
                children: anggotaFields,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _addAnggotaField();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Tambah anggota',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: 24),
            // CustomUploadFile(
            //   hintText: 'Proposal',
            // ),

            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: Checkbox(
                    value: isInfoChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isInfoChecked = value ?? false;
                      });
                    },
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Saya menyatakan bahwa informasi yang saya berikan adalah benar dan dapat dipertanggung jawabkan',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: Checkbox(
                    value: isAgreeChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreeChecked = value ?? false;
                      });
                    },
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Saya setuju untuk mematuhi semua aturan dan regulasi yang ditetapkan oleh penyelenggara kompetisi',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (isInfoChecked && isAgreeChecked) {
                  Navigator.pop(
                    context,
                  );
                  controller.register(context, widget.id, isTeam,
                      anggotaFields.length, anggotaControllers);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'You must accept the terms and conditions to proceed.'),
                    ),
                  );
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
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Submit',
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
