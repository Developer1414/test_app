import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

Widget loading() {
  return Center(
    child: Container(
      width: 60.0,
      height: 60.0,
      margin: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12.0,
            cornerSmoothing: 0.6,
          ),
        ),
      ),
      child: const Center(
          child: CircularProgressIndicator.adaptive(
        strokeCap: StrokeCap.round,
      )),
    ).blurry(
      blur: 2.5,
      color: Colors.black.withOpacity(0.25),
    ),
  );
}
