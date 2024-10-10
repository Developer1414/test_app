// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/common/widgets/alert_dialog.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';

enum AuthenticationState { login, register }

class AuthenticationController extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;

  AuthenticationController({required this.firebaseAuth});

  bool isLoading = false;
  bool obscureText = true;

  AuthenticationState authenticationState = AuthenticationState.login;

  void setLoading(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }

  void changeVisibilityPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void changeAuthenticationState() {
    authenticationState = authenticationState == AuthenticationState.login
        ? AuthenticationState.register
        : AuthenticationState.login;

    notifyListeners();
  }

  Future authenticate(
      {required BuildContext context,
      required String email,
      required String password}) async {
    setLoading(true);

    if (authenticationState == AuthenticationState.login) {
      await signIn(
        email: email,
        password: password,
        //context: context,
      );
    } else {
      await signUp(
        email: email,
        password: password,
        //context: context,
      );
    }
  }

  Future signIn(
      {
      //required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      // if (e.code == 'user-not-found') {
      //   showAlertDialog(
      //     context: context,
      //     title: 'Error',
      //     content: 'No user found for that email.',
      //   );
      // } else if (e.code == 'wrong-password') {
      //   showAlertDialog(
      //     context: context,
      //     title: 'Error',
      //     content: 'Wrong password provided for that user.',
      //   );
      // }
    }
  }

  Future signUp(
      {
      //required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await UserDatabaseController.createUser();

      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      // if (e.code == 'weak-password') {
      //   showAlertDialog(
      //     context: context,
      //     title: 'Error',
      //     content: 'The password provided is too weak.',
      //   );
      // } else if (e.code == 'email-already-in-use') {
      //   showAlertDialog(
      //     context: context,
      //     title: 'Error',
      //     content: 'The account already exists for that email.',
      //   );
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
