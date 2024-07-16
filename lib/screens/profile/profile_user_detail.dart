import 'dart:io';

import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:edupass_mobile/controllers/users/ProfileUserController.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/error_screen.dart';
import 'package:edupass_mobile/screens/profile/components/dropdown_field.dart';
import 'package:edupass_mobile/screens/profile/components/profile_date_field.dart';
import 'package:edupass_mobile/screens/profile/components/profile_text_field.dart';
import 'package:edupass_mobile/screens/profile/components/upload_image_field.dart';
import 'package:edupass_mobile/screens/profile/components/user_avatar_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// ProfileDetailUser

class ProfileDetailUser extends StatefulWidget {
  const ProfileDetailUser({super.key});

  @override
  State<ProfileDetailUser> createState() => _ProfileDetailUserState();
}

class _ProfileDetailUserState extends State<ProfileDetailUser> {
  String? _selectedImagePath;
  String? _selectedBackgroundPath;
  final UpdateUserController updateController = UpdateUserController();

  void _handleImageSelected(String filePath) {
    setState(() {
      _selectedImagePath = filePath;
      updateController.setImagePath(filePath);
      // updateController.imageController.text = filePath;
    });
    debugPrint('File path: $filePath');
  }

  void _handleBackgroundSelected(String filePath) {
    setState(() {
      _selectedBackgroundPath = filePath;
      updateController.setProofPath(filePath);
      // updateController.proofController.text = filePath;
    });
    debugPrint('File path: $filePath');
  }

  // void dispose() {
  //   _selectedImagePath = null;
  //   _selectedBackgroundPath = null;
  //   debugPrint("Image : $_selectedImagePath");
  //   debugPrint("Proof : $_selectedBackgroundPath");
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileUserController(),
      child: Consumer<ProfileUserController>(
        builder: (context, profileController, child) {
          if (profileController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileController.userData == null) {
            return ErrorScreen(onRetry: profileController.retryFetchUserData);
          }

          // Initialize UpdateUserController's text controllers with data from ProfileUserController
          updateController.firstNameController.text =
              profileController.userData!['biodate']['firstName'] ?? '';
          updateController.lastNameController.text =
              profileController.userData!['biodate']['lastName'] ?? '';
          String birthDate =
              profileController.userData!['biodate']['birthDate'] ?? '';
          if (birthDate.isNotEmpty) {
            updateController.birthDateController.text =
                birthDate.substring(0, 10); // Format date
          }

          updateController.genderController.text =
              profileController.userData!['biodate']['gender'] ?? '';
          updateController.phoneController.text =
              profileController.userData!['biodate']['phone'] ?? '';
          updateController.addressController.text =
              profileController.userData!['biodate']['address'] ?? '';
          updateController.provinceController.text =
              profileController.userData!['biodate']['province'] ?? '';
          updateController.regenciesController.text =
              profileController.userData!['biodate']['regencies'] ?? '';
          updateController.institutionNameController.text =
              profileController.userData!['biodate']['institutionName'] ?? '';
          updateController.studyFieldController.text =
              profileController.userData!['biodate']['field'] ?? '';
          updateController.uniqueIdController.text =
              profileController.userData!['biodate']['pupils'] ?? '';
          // updateController.imageController.text =
          //     profileController.userData!['biodate']['image'];
          // updateController.proofController.text =
          //     profileController.userData!['biodate']['proof'];
          // updateController.setImagePath(
          //     profileController.userData!['biodate']['image'] ?? '');
          // updateController.setProofPath(
          //     profileController.userData!['biodate']['proof'] ?? '');

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
                      builder: (context) =>
                          const EduPassApp(initialPageIndex: 4),
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
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 30),
                child: Column(
                  children: [
                    UserAvatarField(onFileSelected: _handleImageSelected),
                    const SizedBox(height: 20),
                    if (_selectedImagePath != null) ...[
                      Text('Selected file: $_selectedImagePath'),
                      // Jika Anda ingin menampilkan gambar yang diunggah
                      Image.file(
                        File(_selectedImagePath!),
                        height: 200,
                      ),
                    ],
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Nama Depan',
                      placeholder: 'John',
                      controller: updateController.firstNameController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Nama Belakang',
                      placeholder: 'Doe',
                      controller: updateController.lastNameController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Email',
                      placeholder: 'stevejobs@gmail.com',
                      enabled: false,
                      controller: TextEditingController(
                        text: profileController.userData!['email'] ?? '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileDateField(
                      label: 'Select Date',
                      placeholder: 'YYYY-MM-DD',
                      controller: updateController.birthDateController,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint(
                            'Selected Date: ${updateController.birthDateController.text}');
                      },
                      child: const Text('Print Selected Date'),
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: 'Jenis Kelamin',
                      items: const ['Pria', 'Wanita', ''],
                      controller: updateController.genderController,
                      onChanged: (value) {
                        debugPrint(
                            'Selected Gender: ${updateController.genderController.text}');
                      },
                    ),
                    const SizedBox(height: 16),
                    UploadImageField(onFileSelected: _handleBackgroundSelected),
                    const SizedBox(height: 20),
                    if (_selectedBackgroundPath != null) ...[
                      Text('Selected file: $_selectedBackgroundPath'),
                      // Jika Anda ingin menampilkan gambar yang diunggah
                      Image.file(
                        File(_selectedBackgroundPath!),
                        height: 200,
                      ),
                    ],
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Provinsi',
                      placeholder: 'California',
                      controller: updateController.provinceController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Regencies',
                      placeholder: 'San Francisco',
                      controller: updateController.regenciesController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Nomor HP',
                      placeholder: '08123456789',
                      controller: updateController.phoneController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Alamat',
                      placeholder: 'Jalan Jendral Sudirman No 1',
                      controller: updateController.addressController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Nama Instansi',
                      placeholder: 'Harvard University',
                      controller: updateController.institutionNameController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'Bidang Studi/Jurusan',
                      placeholder: 'Teknik Informatika',
                      controller: updateController.studyFieldController,
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      label: 'NIM/NISN',
                      placeholder: '123123123',
                      controller: updateController.uniqueIdController,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        updateController.updateBio(context);
                        updateController.reset();

                        // String? image = _selectedImagePath;
                        // String? proof = _selectedBackgroundPath;
                        // updateController.updateBio(context, image, proof);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
