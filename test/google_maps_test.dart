import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';
import 'package:test_app/features/map/controllers/map_controller.dart';

void main() {
  late MapController mapController;

  setUp(() {
    mapController = MapController();
  });

  test('addMarker adds a marker to the markers set', () {
    const LatLng position = LatLng(37.42796133580664, -122.085749655962);
    const String markerId = 'marker1';

    mapController.addTestMarker(position, markerId);

    expect(UserDatabaseController.googleMapsMarkers.length, 1);
    expect(
      UserDatabaseController.googleMapsMarkers.first.markerId.value,
      markerId,
    );
    expect(
      UserDatabaseController.googleMapsMarkers.first.position,
      position,
    );
  });
}
