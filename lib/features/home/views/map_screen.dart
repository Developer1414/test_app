import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_app/common/widgets/icon_button.dart';
import 'package:test_app/common/widgets/loading.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';
import 'package:test_app/features/map/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:test_app/features/map/widgets/weather_info_panel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _HomeState();
}

class _HomeState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserDates();
  }

  Future _loadUserDates() async {
    MapController appController =
        Provider.of<MapController>(context, listen: false);

    await appController.loadUserDates();
    await appController.getWeatherInfo();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MapController appController = context.watch<MapController>();

    return SafeArea(
      child: Scaffold(
        body: appController.currentUserPosition == null
            ? loading()
            : Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                        target: appController.currentUserPosition!),
                    onMapCreated: (GoogleMapController controller) {
                      if (!appController.controller.isCompleted) {
                        appController.controller.complete(controller);
                      }
                    },
                    onTap: (argument) {
                      appController.addCustomMarker(
                          LatLng(argument.latitude, argument.longitude),
                          context);
                    },
                    markers: Set<Marker>.of(
                        UserDatabaseController.googleMapsMarkers),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        weatherInfoPanel(appController),
                        const SizedBox(width: 12.0),
                        UserDatabaseController.googleMapsMarkers.isEmpty
                            ? Container()
                            : iconButton(
                                icon: Icons.delete_rounded,
                                onTap: () =>
                                    appController.removeAllMarkers(context),
                                color: Colors.redAccent,
                              ),
                      ],
                    ),
                  ),
                  !appController.isLoading ? Container() : loading()
                ],
              ),
      ),
    );
  }
}
