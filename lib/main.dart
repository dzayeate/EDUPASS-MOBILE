import 'dart:io';

import 'package:edupass_mobile/screens/authentication/choose_role_screen.dart';
import 'package:edupass_mobile/screens/authentication/forget_password/forget_password.dart';
import 'package:edupass_mobile/screens/authentication/forget_password/reset_password.dart';
import 'package:edupass_mobile/screens/authentication/forget_password/success_reset_password.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/authentication/register_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/general_regis_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/mhs_regis_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/organizers_regis_screen.dart';
import 'package:edupass_mobile/screens/comp_registration/comp_regis_mhs.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/home/detail_comp.dart';
import 'package:edupass_mobile/screens/home/home_screen.dart';
import 'package:edupass_mobile/screens/profile/certification/certification_screen.dart';
import 'package:edupass_mobile/screens/profile/education/education_screen.dart';
import 'package:edupass_mobile/screens/profile/profile_user_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      // Add other routes here
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'Edupass',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
