import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/components/custom_upload_file.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompetitionMhsRegis extends StatefulWidget {
  const CompetitionMhsRegis({super.key});

  @override
  State<CompetitionMhsRegis> createState() => _CompetitionMhsRegisState();
}

class _CompetitionMhsRegisState extends State<CompetitionMhsRegis> {
  bool isInfoChecked = false;
  bool isAgreeChecked = false;
  List<Widget> anggotaFields = [];

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
          "Register Your Team",
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
              'Complete the registration form below',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            const CustomTextField(
              labelText: 'Team Leader',
              hintText: 'Team Leader FullName',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'NIS',
              hintText: 'Insert NIS',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Domicile',
              hintText: 'Enter the domicile',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Email',
              hintText: 'Email',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Agency Name',
              hintText: 'Enter The Name of The Agency',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Agency Domicile',
              hintText: 'Agency Domicile',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Program Studi',
              hintText: 'Nama Program Studi',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Nama Tim',
              hintText: 'Masukkan Nama Tim',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Jumlah Anggota',
              hintText: 'Jumlah Anggota',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Nama Anggota',
              hintText: 'Nama Anggota',
              readOnly: false,
            ),
            Column(
              children: anggotaFields,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  anggotaFields.add(
                    const Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          labelText: 'Nama Anggota',
                          hintText: 'Nama Anggota',
                          readOnly: false,
                        ),
                      ],
                    ),
                  );
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
            const SizedBox(height: 16),
            const CustomUploadFile(
              hintText: 'Proposal',
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              title: const Text(
                'Saya menyatakan bahwa informasi yang saya berikan adalah benar dan dapat dipertanggung jawabkan',
                style: TextStyle(fontSize: 12),
              ),
              value: isInfoChecked,
              onChanged: (bool? value) {
                setState(() {
                  isInfoChecked = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                  'Saya setuju untuk mematuhi semua aturan dan regulasi yang ditetapkan oleh penyelenggara kompetisi',
                  style: TextStyle(fontSize: 12)),
              value: isAgreeChecked,
              onChanged: (bool? value) {
                setState(() {
                  isAgreeChecked = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (isInfoChecked && isAgreeChecked) {
                  Navigator.pop(context);
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
              child: Text(
                'Submit',
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
    );
  }
}
