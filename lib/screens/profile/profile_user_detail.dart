import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/components/dropdown_field.dart';
import 'package:edupass_mobile/screens/profile/components/profile_text_field.dart';
import 'package:edupass_mobile/screens/profile/components/upload_image_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailUser extends StatelessWidget {
  const ProfileDetailUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EduPassApp(initialPageIndex: 4),
              ),
            );
          },
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person, size: 50, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            const ProfileTextField(
                label: 'Nama Depan', placeholder: 'Placeholder'),
            const SizedBox(height: 16),
            const ProfileTextField(
                label: 'Nama Belakang', placeholder: 'Placeholder'),
            const SizedBox(height: 16),
            const ProfileTextField(
              label: 'Email',
              placeholder: 'stevejobs@gmail.com',
              enabled: false,
            ),
            const SizedBox(height: 16),
            UploadImageField(
              onFileSelected: (filePath) {
                // Handle file path
                print('Selected file path: $filePath');
              },
            ),
            const SizedBox(height: 16),
            const DropdownField(
              label: 'Provinsi',
            ),
            const SizedBox(height: 16),
            const DropdownField(label: 'Kabupaten/ Kota'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle edit button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Edit',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
