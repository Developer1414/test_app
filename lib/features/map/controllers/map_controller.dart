import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';
import 'dart:convert';
import 'dart:async';
import 'package:test_app/features/map/models/weather_info_model.dart';
import 'package:test_app/features/map/widgets/bottom_modal_sheet_new_marker.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MapController extends ChangeNotifier {
  bool isLoading = false;

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  Location locationController = Location();
  LatLng? currentUserPosition;

  WeatherInfoModel? weatherInfoModel;

  void setLoading(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }

  Future getUserLocation() async {
    if (await Permission.location.isGranted) {
      bool serviceEnabled = await locationController.serviceEnabled();

      if (serviceEnabled) {
        serviceEnabled = await locationController.requestService();
      }

      await locationController.getLocation().then((value) async {
        if (value.latitude != null && value.longitude != null) {
          currentUserPosition = LatLng(value.latitude!, value.longitude!);
          await getWeatherInfo();
        }
      });
    } else {
      bool isLocationGranted = await Permission.location.request().isGranted;

      if (isLocationGranted) {
        await getUserLocation();
      }
    }
  }

  void addTestMarker(LatLng position, String id) {
    UserDatabaseController.googleMapsMarkers.add(Marker(markerId: MarkerId(id), position: position));
    notifyListeners();
  }

  Future loadUserDates() async {
    await getUserLocation();
    await UserDatabaseController.getUserDates();
  }

  Future getWeatherInfo() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${currentUserPosition!.latitude}&lon=${currentUserPosition!.longitude}&units=metric&appid=a4e60d17353ff88c7d6bb4974ce794fc'));
      weatherInfoModel = WeatherInfoModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      if (kDebugMode) {
        print('FetchWeatherError: $e');
      }
    }
  }

  Future addCustomMarker(LatLng tapPosition, BuildContext context) async {
    await WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) => [
        bottomModalSheetNewMarker(
          bottomSheetContext: bottomSheetContext,
          tapPosition: tapPosition,
        ),
      ],
    );

    notifyListeners();
  }

  Future removeAllMarkers(BuildContext context) async {
    setLoading(true);

    await Provider.of<UserDatabaseController>(context, listen: false)
        .deleteAllMarkers();

    setLoading(false);
  }
}
