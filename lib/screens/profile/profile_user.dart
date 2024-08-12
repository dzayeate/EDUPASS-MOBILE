import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:edupass_mobile/api/shared_preferences/biodate_id_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:edupass_mobile/api/shared_preferences/user_id_manager.dart';
import 'package:edupass_mobile/controllers/users/profile_user_controller.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/error_screen.dart';
import 'package:edupass_mobile/screens/profile/activity/activity_user.dart';
import 'package:edupass_mobile/screens/profile/certification/certification_screen.dart';
import 'package:edupass_mobile/screens/profile/education/education_screen.dart';
import 'package:edupass_mobile/screens/profile/profile_detail_user.dart';
import 'package:edupass_mobile/screens/profile/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileUserController(),
      child: WillPopScope(
        onWillPop: () async {
          // Menangani ketika tombol back ditekan
          SystemNavigator.pop(); // Keluar dari aplikasi
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Consumer<ProfileUserController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.userData == null) {
                  return ErrorScreen(onRetry: controller.retryFetchUserData);
                } else {
                  // Check if any fields in 'biodate' are empty or null
                  bool isBiodateIncomplete =
                      controller.userData?['biodate'].values.any((value) =>
                              value == null || value.toString().isEmpty) ??
                          true;

                  // Check if user image is null and handle accordingly
                  String? userImage;
                  if (controller.userData?['biodate']['image']['previewUrl'] !=
                      null) {
                    userImage = controller.userData?['biodate']['image']
                            ['previewUrl']
                        ?.replaceAll("localhost", "192.168.1.4");
                  } else {
                    userImage = null;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 165,
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
                        // child: Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: IconButton(
                        //       icon: const Icon(Ionicons.arrow_back),
                        //       color: Colors.white,
                        //       onPressed: () {
                        //         // Handle back button press
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: userImage != null &&
                                            userImage.isNotEmpty
                                        ? NetworkImage(userImage)
                                        : const NetworkImage(
                                            'https://i.pravatar.cc/150?img=3'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -30),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(controller.userData?['biodate']['firstName'].isEmpty ?? true) || (controller.userData?['biodate']['lastName'].isEmpty ?? true) ? 'Halo User' : '${controller.userData?['biodate']['firstName']} ${controller.userData?['biodate']['lastName']}'}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        if (controller
                                                .userData?['isVerified'] !=
                                            null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.userData?[
                                                              'isVerified'] ==
                                                          true
                                                      ? const Color.fromARGB(
                                                          255, 188, 229, 249)
                                                      : Color.fromARGB(
                                                          255, 251, 214, 227),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: controller.userData?[
                                                            'isVerified'] ==
                                                        true
                                                    ? const Color.fromARGB(
                                                        255, 108, 167, 255)
                                                    : Color.fromARGB(
                                                        255, 245, 99, 177)!,
                                                width:
                                                    2, // Set the width of the border
                                              ),
                                            ),
                                            child: Text(
                                              controller.userData?[
                                                          'isVerified'] ==
                                                      true
                                                  ? 'Verified'
                                                  : 'Not Verified',
                                              style: TextStyle(
                                                color: controller.userData?[
                                                            'isVerified'] ==
                                                        true
                                                    ? Colors.indigo
                                                    : Colors.red[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      controller.userData?['email'] ??
                                          'stevejobs@gmail.com',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      controller.userData?['role']['name'] ??
                                          'Mahasiswa',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (isBiodateIncomplete)
                                      Transform.translate(
                                        offset: const Offset(-12, 0),
                                        child: TextButton(
                                          onPressed: () {
                                            // Handle add bio button press
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileDetailUser(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Anda belum menambahkan bio, Tambahkan sekarang!',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.indigo,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.translate(
                          offset: const Offset(0, -30),
                          child: ListView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            children: [
                              ListTile(
                                leading: const Icon(Ionicons.settings_outline),
                                title: const Text('Edit Profile'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileDetailUser()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Ionicons.list_outline),
                                title: const Text('Activity'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ActivityUser()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Ionicons.school_outline),
                                title: const Text('Education'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EducationScreen()),
                                  );
                                },
                              ),
                              ListTile(
                                leading:
                                    const Icon(Ionicons.document_text_outline),
                                title:
                                    const Text('Your Licenses & Certificates'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CertificationScreen()),
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
                                        builder: (context) =>
                                            const SettingScreen()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: const Icon(Ionicons.log_out_outline),
                                title: const Text('Log Out'),
                                onTap: () async {
                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor: Colors.transparent,
                                    content: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: AwesomeSnackbarContent(
                                        titleFontSize: 17,
                                        messageFontSize: 15,
                                        title: 'User Log Out!',
                                        message: 'Log Out Successfully!',
                                        contentType: ContentType.failure,
                                      ),
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  // await AuthService().logout();
                                  // await AuthService().deleteToken();
                                  await TokenManager().deleteToken();
                                  await BiodateIdManager().deleteBiodateId();
                                  await BiodateIdManager().checkBiodateId();
                                  await UserIdManager().deleteId();
                                  // context.go('/');

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
