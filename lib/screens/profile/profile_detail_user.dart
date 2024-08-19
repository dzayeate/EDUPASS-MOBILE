import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:edupass_mobile/controllers/users/profile_user_controller.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/error_screen.dart';
import 'package:edupass_mobile/screens/components/dropdown_field.dart';
import 'package:edupass_mobile/screens/components/custom_date_field.dart';
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
  bool _dataInitialized = false;

  final UpdateUserController updateController = UpdateUserController();

  void _handleImageSelected(String filePath) {
    setState(() {
      _selectedImagePath = filePath;
      updateController.setImagePath(filePath);
      // updateController.imageController.text = filePath;
    });
    debugPrint('File path: $filePath');
  }

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
          if (!_dataInitialized) {
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

            // Cek apakah image itu null atau tidak sebelum mengakses previewUrl
            var image = profileController.userData!['biodate']['image'];
            if (image['previewUrl'] != null) {
              updateController.imageController.text =
                  image['previewUrl'].replaceAll("localhost", "192.168.1.4");
            } else {
              updateController.imageController.text = '';
            }

            _dataInitialized = true;
          }

          // Cek role pengguna
          String roleName = profileController.userData!['role']['name'] ?? '';

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                    UserAvatarField(
                      onFileSelected: _handleImageSelected,
                      imagePath: _selectedImagePath ??
                          profileController.userData!['biodate']['image']
                                  ['previewUrl']
                              ?.replaceAll("localhost", "192.168.1.4"),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Nama Depan',
                      hintText: 'John',
                      controller: updateController.firstNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Nama Belakang',
                      hintText: 'Doe',
                      controller: updateController.lastNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Email',
                      hintText: 'stevejobs@gmail.com',
                      enabled: false,
                      controller: TextEditingController(
                        text: profileController.userData!['email'] ?? '',
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomDateField(
                      label: 'Select Date',
                      placeholder: 'YYYY-MM-DD',
                      controller: updateController.birthDateController,
                    ),
                    const SizedBox(height: 16),
                    DropdownField(
                      label: 'Jenis Kelamin',
                      items: const [
                        'Pria',
                        'Wanita',
                        'Female',
                        'Male',
                        'Laki_laki',
                        ''
                      ],
                      controller: updateController.genderController,
                      onChanged: (value) {
                        debugPrint(
                            'Selected Gender: ${updateController.genderController.text}');
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Provinsi',
                      hintText: 'California',
                      controller: updateController.provinceController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Kabupaten/Kota',
                      hintText: 'San Francisco',
                      controller: updateController.regenciesController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Nomor HP',
                      hintText: '08123456789',
                      controller: updateController.phoneController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Alamat',
                      hintText: 'Jalan Jendral Sudirman No 1',
                      controller: updateController.addressController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Nama Institusi',
                      hintText: 'Harvard University',
                      controller: updateController.institutionNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Bidang Studi/Jurusan',
                      hintText: 'Teknik Informatika',
                      controller: updateController.studyFieldController,
                    ),
                    const SizedBox(height: 16),
                    if (roleName == 'Umum' ||
                        roleName == 'Mahasiswa' ||
                        roleName == 'Siswa')
                      CustomTextField(
                        labelText: 'NIM/NISN',
                        hintText: '123123123',
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
