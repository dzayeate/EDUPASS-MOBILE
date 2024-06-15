import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/profile_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EduPassApp(initialPageIndex: 4),
              ),
            );
          },
        ),
        title: Text('Settings', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            _buildSettingsOption('Account Privacy'),
            _buildSettingsOption('Change Password'),
            _buildSettingsOption('Delete Account'),
            _buildSettingsOption('Tags/Interest'),
            _buildSettingsOption('Sosial Media'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(CupertinoIcons.forward),
      onTap: () {
        // Navigate to respective page
      },
    );
  }
}
