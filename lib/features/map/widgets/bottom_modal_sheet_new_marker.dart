import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_app/common/widgets/text_button.dart';
import 'package:test_app/common/widgets/text_field.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

SliverWoltModalSheetPage bottomModalSheetNewMarker({
  required BuildContext bottomSheetContext,
  required LatLng tapPosition,
}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController snippetController = TextEditingController();

  return SliverWoltModalSheetPage(
    enableDrag: false,
    isTopBarLayerAlwaysVisible: true,
    topBarTitle: Text(
      'New marker',
      style: GoogleFonts.manrope(
        fontSize: 22.0,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    ),
    trailingNavBarWidget: Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        icon: const Icon(Icons.close_rounded),
        onPressed: () => Navigator.of(bottomSheetContext).pop(),
      ),
    ),
    mainContentSliversBuilder: (context) => [
      SliverList.list(
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: textField(
              hintText: 'Title...',
              controller: titleController,
              context: context,
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: textField(
              hintText: 'Snippet...',
              controller: snippetController,
              context: context,
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding:
                const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: textButton(
              title: 'Done',
              textColor: Colors.white,
              isLoading: Provider.of<UserDatabaseController>(context, listen: false).isLoading,
              backgroundColor: Colors.blueAccent,
              onTap: () async {
                await Provider.of<UserDatabaseController>(context,
                        listen: false)
                    .createMarker(
                  Marker(
                    markerId: MarkerId(
                        DateTime.now().millisecondsSinceEpoch.toString()),
                    icon: BitmapDescriptor.defaultMarker,
                    position: tapPosition,
                    infoWindow: InfoWindow(
                      title: titleController.text,
                      snippet: snippetController.text,
                    ),
                  ),
                );

                if (bottomSheetContext.mounted) {
                  Navigator.of(bottomSheetContext).pop();
                }
              },
            ),
          ),
        ],
      ),
    ],
  );
}
