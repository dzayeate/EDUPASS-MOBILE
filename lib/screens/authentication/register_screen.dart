import 'package:edupass_mobile/controllers/auth/register_controller.dart';
import 'package:edupass_mobile/screens/authentication/login_screen.dart';
import 'package:edupass_mobile/screens/components/custom_form_field.dart';
import 'package:edupass_mobile/screens/terms_and_condition/TermsConditionScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController _registerController = RegisterController();
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edu",
                              style: GoogleFonts.poppins(
                                color: Colors.blue,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Pass",
                              style: GoogleFonts.poppins(
                                color: Colors.red[400],
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomFormField(
                        controller: _registerController.emailController,
                        labelText: 'Email',
                        validator: emailValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        controller: _registerController.passwordController,
                        labelText: 'Password',
                        isPassword: true,
                        validator: passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        controller:
                            _registerController.confirmPasswordController,
                        labelText: 'Confirm Password',
                        isPassword: true,
                        validator: (value) => confirmPasswordValidator(
                            value, _registerController.passwordController.text),
                      ),
                      const SizedBox(height: 20),
                      Transform.translate(
                        offset: const Offset(-24, 0),
                        child: CheckboxListTile(
                          title: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsConditionScreen()),
                              );
                            },
                            child: const Text(
                              "Terms & Condition",
                              style: TextStyle(
                                  color: Colors.indigo, // Warna biru
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.indigo),
                            ),
                          ),
                          value: _isTermsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTermsAccepted = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_isTermsAccepted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please Accept the Terms & Condition"),
                                ),
                              );
                              return;
                            }

                            final emailError = emailValidator(
                                _registerController.emailController.text);
                            final passwordError = passwordValidator(
                                _registerController.passwordController.text);
                            final confirmPasswordError =
                                confirmPasswordValidator(
                                    _registerController
                                        .confirmPasswordController.text,
                                    _registerController
                                        .passwordController.text);

                            if (emailError == null &&
                                passwordError == null &&
                                confirmPasswordError == null) {
                              _registerController.register(context);
                            }

                            // Validasi dan simpan data dari RegisterScreen ke RegisterController
                            // _registerController.addFirstStepData(
                            //   email: _registerController.emailController.text
                            //       .trim(),
                            //   password: _registerController
                            //       .passwordController.text
                            //       .trim(),
                            //   confirmPassword: _registerController
                            //       .confirmPasswordController.text
                            //       .trim(),
                            // );

                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const EduPassApp()
                            //       // ChooseRoleScreen()
                            //       ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          'Atau Lanjutkan Dengan',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('assets/images/google.png'),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: Image.asset('assets/images/facebook.png'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya Akun ?',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Aksi ketika tombol ditekan
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Login!',
                              style: TextStyle(
                                  color: Colors.blue, // Warna biru
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
