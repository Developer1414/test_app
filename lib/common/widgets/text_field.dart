import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/features/authentication/controllers/authentication_controller.dart';

Widget textField({
  required String hintText,
  required TextEditingController controller,
  bool readOnly = false,
  TextInputType? keyboardType,
  AuthenticationController? authenticationController,
  required BuildContext context,
  bool isPassword = false,
}) {
  return TextField(
    controller: controller,
    readOnly: readOnly,
    keyboardType: keyboardType,
    textInputAction: TextInputAction.done,
    obscureText: authenticationController?.obscureText ?? false,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.manrope(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black87.withOpacity(0.5),
      ),
      suffixIcon: !isPassword
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: Icon(
                  authenticationController!.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.blueAccent.withOpacity(0.8),
                ),
                onPressed: () =>
                    authenticationController.changeVisibilityPassword(),
              ),
            ),
      fillColor: Colors.blueAccent.withOpacity(0.1),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          width: 2.5,
          color: Colors.blueAccent.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(
          width: 2.5,
          color: Colors.blueAccent.withOpacity(0.7),
        ),
      ),
    ),
    onTapOutside: (event) {
      FocusScope.of(context).unfocus();
    },
    style: GoogleFonts.manrope(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  );
}
