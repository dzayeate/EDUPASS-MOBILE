import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EduPassApp(initialPageIndex: 4),
              ),
            );
          },
        ),
        title: Text(
          'Education',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CustomTextField(
                labelText: 'Nama Instansi',
                hintText: 'Universitas Pasundan',
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                labelText: 'Tingkat Instansi',
                hintText: 'Sarjana',
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                labelText: 'Bidang Studi',
                hintText: 'Teknik Informatika',
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                labelText: 'Alasan Bergabung',
                hintText: 'Alasan Bergabung',
                alignLabelWithHint: true,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  'Kembali',
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
      ),
    );
  }
}
