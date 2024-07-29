import 'package:edupass_mobile/api/auth/auth_service.dart';
import 'package:edupass_mobile/api/shared_preferences/token_manager.dart';
import 'package:edupass_mobile/controllers/competition/get/get_comp_controller.dart';
import 'package:edupass_mobile/screens/authentication/choose_role_screen.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/authentication/registration_role/general_regis_screen.dart';
import 'package:edupass_mobile/screens/competition_task/comp_registration/comp_regis_mhs.dart';
import 'package:edupass_mobile/screens/competition_task/comp_task/competiton_task.dart';
import 'package:edupass_mobile/screens/edupass_app.dart';
import 'package:edupass_mobile/screens/profile/profile_user.dart';
import 'package:edupass_mobile/screens/profile/profile_user_detail.dart';
import 'package:edupass_mobile/screens/terms_and_condition/TermsConditionScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool loggedIn = await TokenManager().isLoggedIn();

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
              loggedIn ? EduPassApp() : const LoginScreen(),
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
        title: 'MyApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      ),
    );
  }
}
