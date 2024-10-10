import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

Widget iconButton({
  required IconData icon,
  required VoidCallback onTap,
  Color? color,
}) {
  return SizedBox(
    width: 50.0,
    height: 50.0,
    child: ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(5.0),
        backgroundColor: color?.withOpacity(0.8),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12.0,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      icon: Expanded(
        child: Icon(
          icon,
          size: 23.0,
          color: Colors.white,
        ),
      ),
      label: const SizedBox(
        height: 0.0,
        width: 0.0,
      ),
    ),
  );
}
