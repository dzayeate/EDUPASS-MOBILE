import 'dart:io';

import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await TokenManager().isLoggedIn();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({required this.loggedIn, super.key});

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetCompetitionController()),
        // Add other providers here if needed
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        title: 'EduPas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      ),
    );
  }
}

// Hanya untuk Testing
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
