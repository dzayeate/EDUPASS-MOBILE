import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/profile/certification/certification_screen.dart';
import 'package:edupass_mobile/screens/profile/education/education_screen.dart';
import 'package:edupass_mobile/screens/profile/profile_user_detail.dart';
import 'package:edupass_mobile/screens/profile/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.purpleAccent,
                    Colors.orange.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Ionicons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      // Handle back button press
                    },
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steve Jobs',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'stevejobs@gmail.com',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Mahasiswa',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  ListTile(
                    leading: const Icon(Ionicons.settings_outline),
                    title: const Text('Edit Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileDetailUser()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.list_outline),
                    title: const Text('Activity'),
                    onTap: () {
                      // Handle activity tap
                    },
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.school_outline),
                    title: const Text('Education'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EducationScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.document_text_outline),
                    title: const Text('Your Licenses & Certificates'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CertificationScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.cog_outline),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.log_out_outline),
                    title: const Text('Log Out'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
