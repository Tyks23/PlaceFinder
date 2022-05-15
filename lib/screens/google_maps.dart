import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/http_service.dart';
import '../models/place_model.dart';

class GoogleMaps extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Place place;

  GoogleMaps({Key? key, required this.place}) : super(key: key);

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(59.399451643677054, 24.637874734549047)
          //place.latitude, place.longitude
          );
  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color(0xffd7ae9c);
    var buttonColor = const Color(0xff795548);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text(place.name, style: const TextStyle(fontSize: 26)),
        ),
        body: const GoogleMap(
          initialCameraPosition: _initialCameraPosition,
        ));
  }
}
