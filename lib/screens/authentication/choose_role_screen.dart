import 'package:edupass_mobile/screens/authentication/registration_role/general_regis_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/mhs_regis_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/organizers_regis_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/siswa_regis_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String? _selectedRole;

  void _navigateToRoleScreen() {
    if (_selectedRole == null) return;

    Widget screen;
    switch (_selectedRole) {
      case 'User':
        screen = const GeneralRegister();
        break;
      case 'Student':
        screen = const SiswaRegister();
        break;
      case 'Mahasiswa':
        screen = const MahasiswaRegister();
        break;
      case 'EO':
        screen = const OrganizersRegister();
        break;
      case 'Sponsor':
        screen = const OrganizersRegister();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add back button functionality here
            Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            //  DropdownField(
            //             label: 'Jenis Kelamin',
            //             items: const ['SD', 'SMP', 'SMA', 'Mahasiswa', ''],
            //             controller: updateController.genderController,
            //             onChanged: (value) {
            //               debugPrint(
            //                   'Selected Gender: ${updateController.genderController.text}');
            //             },
            //           ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToRoleScreen,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
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
            ),
          ],
        ),
      ),
    );
  }
}
