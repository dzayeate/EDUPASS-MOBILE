import 'package:edupass_mobile/screens/components/custom_dropdown.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/components/custom_upload_field.dart';
import 'package:edupass_mobile/screens/components/upload_file_field.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiswaRegister extends StatefulWidget {
  const SiswaRegister({super.key});

  @override
  State<SiswaRegister> createState() => _SiswaRegisterState();
}

class _SiswaRegisterState extends State<SiswaRegister> {
  bool isChecked = false;

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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edu",
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Pass",
              style: GoogleFonts.poppins(
                color: Colors.red[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Get Started',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please enter your biodata',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: Colors.black,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: Colors.black,
                )),
              ],
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Nama Depan',
              hintText: 'Contoh: Dzikry',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Nama Belakang',
              hintText: 'Contoh: Habibie',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'NISN',
              hintText: 'NISN',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomUploadFile(
              hintText: 'Upload Foto',
            ),
            const SizedBox(height: 16),
            CustomDropDown(
              items: const ['SD', 'SMP', 'SMA', 'Mahasiswa'],
              hint: 'Tingkat Instansi',
              onChanged: (value) {
                // Handle value change
              },
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Provinsi',
              hintText: 'Jawa Barat',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Kabupaten/Kota',
              hintText: 'Bandung',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Bidang studi / Jurusan',
              hintText: 'Teknik Informatika',
              readOnly: false,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              labelText: 'Alasan Bergabung',
              hintText: 'Alasan Bergabung',
              alignLabelWithHint: true,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                const Text('Term and Condition'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (isChecked) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EduPassApp(),
                    ),
                  );
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
