import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/http_service.dart';
import '../models/place_model.dart';

class GoogleMaps extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Place place;

  GoogleMaps({Key? key, required this.place}) : super(key: key);
  List<Marker> allMarkers = [];

  @override
  Widget build(BuildContext context) {
    var _initialCameraPosition = CameraPosition(
        target:
            LatLng(double.parse(place.latitude), double.parse(place.longitude)),
        zoom: 15);

    var primaryColor = const Color(0xffd7ae9c);
    var buttonColor = const Color(0xff795548);

    allMarkers.add(Marker(
        markerId: MarkerId("Location Marker"),
        draggable: false,
        position: LatLng(
            double.parse(place.latitude), double.parse(place.longitude))));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text(place.name, style: const TextStyle(fontSize: 26)),
        ),
        body: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          markers: Set.from(allMarkers),
        ));
  }
}
