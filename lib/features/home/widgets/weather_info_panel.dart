import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/features/map/controllers/map_controller.dart';

Widget weatherInfoPanel(MapController appController) {
  return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 12.0,
                cornerSmoothing: 0.6,
              ),
            ),
          ),
          child: appController.weatherInfoModel == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    panel(
                      text: '${appController.weatherInfoModel!.temp}°',
                      icon: Icons.thermostat_rounded,
                    ),
                    panel(
                      text: '${appController.weatherInfoModel!.humidity}%',
                      icon: Icons.water_drop_rounded,
                    ),
                    panel(
                      text: '${appController.weatherInfoModel!.speed}m/s',
                      icon: Icons.air_rounded,
                    ),
                  ],
                ))
      .blurry(
    blur: 2.5,
    color: Colors.black.withOpacity(0.25),
  );
}

Widget panel({required String text, required IconData icon}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20.0,
        color: const Color(0xffEBEBEB),
      ),
      const SizedBox(width: 5.0),
      Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: const Color(0xffEBEBEB),
        ),
      ),
    ],
  );
}
