import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/features/authentication/models/marker_model.dart';

class UserDatabaseController extends ChangeNotifier {
  static Set<Marker> googleMapsMarkers = {};

  bool isLoading = false;

  void setLoading(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }

  static Future createUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'user_id': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  static Future getUserDates() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        return;
      }

      if (!value.data()!.containsKey('markers')) {
        return;
      }

      for (var item in value.data()?['markers']) {
        MarkerModel marker = MarkerModel.fromJson(item);

        googleMapsMarkers.add(Marker(
          markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
          position: LatLng(marker.latitude, marker.longitude),
          infoWindow: InfoWindow(title: marker.title, snippet: marker.snippet),
        ));
      }
    });
  }

  Future createMarker(Marker marker) async {
    setLoading(true);

    List markersJson = [];

    googleMapsMarkers.add(marker);

    for (var item in googleMapsMarkers) {
      markersJson.add(
        MarkerModel(
                title: item.infoWindow.title ?? 'No title',
                snippet: item.infoWindow.snippet ?? 'No snippet',
                latitude: item.position.latitude,
                longitude: item.position.longitude)
            .toJson(),
      );
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'markers': markersJson,
    });

    setLoading(false);
  }

  Future deleteAllMarkers() async {
    googleMapsMarkers.clear();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'markers': FieldValue.delete(),
    });
  }
}
