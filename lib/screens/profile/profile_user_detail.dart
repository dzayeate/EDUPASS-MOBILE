import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/components/dropdown_field.dart';
import 'package:edupass_mobile/screens/profile/components/profile_text_field.dart';
import 'package:edupass_mobile/screens/profile/components/upload_image_field.dart';
import 'package:edupass_mobile/screens/profile/components/user_avatar_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailUser extends StatelessWidget {
  const ProfileDetailUser({super.key});

  @override
  Widget build(BuildContext context) {
    final UpdateUserController controller = UpdateUserController();

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
                builder: (context) => const EduPassApp(initialPageIndex: 4),
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
      body: Container(
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30),
          child: Column(
            children: [
              UserAvatarField(onFileSelected: (filePath) {
                // Handle the selected file path
                debugPrint('Selected file path: $filePath');
                controller.imageController.text = filePath;
              }),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Nama Depan',
                placeholder: 'John',
                controller: controller.firstNameController,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Nama Belakang',
                placeholder: 'Doe',
                controller: controller.lastNameController,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Email',
                placeholder: 'stevejobs@gmail.com',
                enabled: false,
                controller:
                    TextEditingController(), // Placeholder controller, replace as needed
              ),
              const SizedBox(height: 16),
              DropdownField(
                label: 'Gender',
                items: [
                  'Pria',
                  'Wanita',
                ],
                controller: controller.genderController,
                onChanged: (value) {
                  print('Selected Gender: ${controller.genderController.text}');
                },
              ),
              const SizedBox(height: 16),
              UploadImageField(
                onFileSelected: (filePath) {
                  debugPrint('Selected file path: $filePath');

                  controller.proofController.text = filePath;
                },
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Provinsi',
                placeholder: 'Jawa Barat',
                controller: controller.provinceController,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Nama Instansi',
                placeholder: 'Universitas Pasundan',
                controller: controller.institutionNameController,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'Bidang Studi/Jurusan',
                placeholder: 'Teknik Informatika',
                controller: controller.studyFieldController,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                label: 'NIM/NISN',
                placeholder: '213040133',
                controller: controller.uniqueIdController,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Handle edit button press
                  controller.updateBio(context);
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
      ),
    );
  }
}
