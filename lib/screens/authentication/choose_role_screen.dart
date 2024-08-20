import 'package:edupass_mobile/controllers/auth/change_role_controller.dart';
import 'package:edupass_mobile/screens/components/dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  final ChangeRoleController _changeRolecontroller = ChangeRoleController();

  @override
  void dispose() {
    _changeRolecontroller
        .dispose(); // Panggil dispose dari controller saat widget ini dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
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
              'Ganti Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih Role sesuai keinginan anda',
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
            DropdownButtonFormField<String>(
              value: null,
              hint: const Text('Ganti Role'),
              items: const [
                DropdownMenuItem(value: 'Siswa', child: Text('Siswa')),
                DropdownMenuItem(value: 'Mahasiswa', child: Text('Mahasiswa')),
                DropdownMenuItem(
                    value: 'Perusahaan', child: Text('Perusahaan')),
                DropdownMenuItem(value: 'EO', child: Text('EO')),
                DropdownMenuItem(value: 'Sponsor', child: Text('Sponsor')),
                DropdownMenuItem(value: 'Juri', child: Text('Juri')),
              ],
              onChanged: (value) {
                setState(() {
                  _changeRolecontroller.roleNameController.text = value ?? '';
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_changeRolecontroller.roleNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Silahkan pilih role terlebih dahulu'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  _changeRolecontroller.changeRole(context);
                },
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
