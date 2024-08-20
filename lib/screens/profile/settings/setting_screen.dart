import 'package:edupass_mobile/screens/authentication/change_password/change_password.dart';
import 'package:edupass_mobile/screens/authentication/choose_role_screen.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _buildSettingsOption(context, 'Change Password'),
            _buildSettingsOption(context, 'Change Role'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(CupertinoIcons.forward),
      onTap: () {
        // Navigate to respective page
        if (title == 'Change Password') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen()),
          );
        }
        if (title == 'Change Role') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChooseRoleScreen()),
          );
        } else {
          // Handle other options
        }
      },
    );
  }
}
