import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/screens/authentication/choose_role_screen.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/general_regis_screen.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/profile_user.dart';
import 'package:edupass_mobile/screens/profile/profile_user_detail.dart';
import 'package:edupass_mobile/screens/terms_and_condition/TermsConditionScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await AuthService().isLoggedIn();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  MyApp({required this.loggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              loggedIn ? const EduPassApp() : const LoginScreen(),
        ),
        // Add other routes here
        GoRoute(
          path: '/home',
          builder: (context, state) => const EduPassApp(),
        ),
      ],
    );

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
