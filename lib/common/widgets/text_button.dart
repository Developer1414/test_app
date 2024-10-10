import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textButton({
  required String title,
  required VoidCallback onTap,
  Color? backgroundColor,
  Color? textColor,
  Size? size,
  bool? isLoading,
}) {
  return SizedBox(
    width: size?.width ?? double.infinity,
    height: size?.height ?? 60.0,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5.0),
        backgroundColor: backgroundColor?.withOpacity(0.8),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12.0,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      child: isLoading != null && isLoading == true
          ? const Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator.adaptive(
                  strokeCap: StrokeCap.round,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                ),
              ),
            )
          : Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: textColor ?? const Color(0xffEBEBEB),
              ),
            ),
    ),
  );
}
