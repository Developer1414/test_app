import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_app/common/widgets/text_button.dart';
import 'package:test_app/common/widgets/text_field.dart';
import 'package:test_app/features/authentication/controllers/authentication_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController =
        context.watch<AuthenticationController>();

    return Scaffold(
      body: authenticationController.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        authenticationController.authenticationState ==
                                AuthenticationState.login
                            ? 'LOGIN'
                            : 'REGISTER',
                        style: GoogleFonts.manrope(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      textField(
                        hintText: 'Email...',
                        controller: emailController,
                        context: context,
                      ),
                      const SizedBox(height: 12.0),
                      textField(
                        hintText: 'Password...',
                        controller: passwordController,
                        authenticationController: authenticationController,
                        isPassword: true,
                        context: context,
                      ),
                      const SizedBox(height: 12.0),
                      textButton(
                        title: authenticationController.authenticationState ==
                                AuthenticationState.login
                            ? 'Sign in'
                            : 'Sign up',
                        textColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        onTap: () async =>
                            await authenticationController.authenticate(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                          context: context,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: authenticationController
                                          .authenticationState ==
                                      AuthenticationState.login
                                  ? 'Don\'t have an account yet? '
                                  : 'Already have an account? ',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => authenticationController
                                    .changeAuthenticationState(),
                              text: authenticationController
                                          .authenticationState ==
                                      AuthenticationState.login
                                  ? 'Sign up!'
                                  : 'Sign in!',
                              style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
