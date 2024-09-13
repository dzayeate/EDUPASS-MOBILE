import 'package:edupass_mobile/controllers/users/profile_user_controller.dart';
import 'package:edupass_mobile/screens/components/custom_text_field.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/error_screen.dart';
import 'package:edupass_mobile/screens/components/upload_file_field.dart';
import 'package:flutter/material.dart';
import 'package:edupass_mobile/controllers/auth/update_user_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final UpdateUserController updateController = UpdateUserController();

  String? _selectedFilePath;
  bool _dataInitialized = false;

  // Fungsi untuk mengambil nama file dari URL
  String extractFileName(String url) {
    Uri uri = Uri.parse(url);
    String fileName = uri.queryParameters['fileName'] ?? '';
    return fileName;
  }

  void _handleFileSelected(String filePath) {
    setState(() {
      _selectedFilePath = filePath;
      updateController.setProofPath(filePath);
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
            // Menggunakan extractFileName untuk mendapatkan nama file
            String proofUrl =
                profileController.userData!['biodate']['proof'] ?? '';
            updateController.proofController.text = extractFileName(proofUrl);

            _dataInitialized = true;
          }

          // Extract the initial file name from the proofController
          String initialFileName =
              updateController.proofController.text.isNotEmpty
                  ? updateController.proofController.text.split('/').last
                  : '';

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                    CustomTextField(
                      labelText: 'Nama Institusi',
                      enabled: false,
                      hintText: 'Harvard University',
                      controller: updateController.institutionNameController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Bidang Studi/Jurusan',
                      enabled: false,
                      hintText: 'Teknik Informatika',
                      controller: updateController.studyFieldController,
                    ),
                    const SizedBox(height: 16),
                    UploadFileField(
                      initialFileName: initialFileName,
                      onFileSelected: _handleFileSelected,
                      allowedExtensions: const [
                        'jpg',
                        'jpeg',
                        'png',
                        'pdf'
                      ], // Allow images and PDFs
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        updateController.updateBio(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
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
            ),
          );
        },
      ),
    );
  }
}
