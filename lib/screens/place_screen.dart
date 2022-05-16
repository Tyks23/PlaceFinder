import 'package:flutter/material.dart';

import './google_maps.dart';
import '../services/http_service.dart';
import '../models/place_model.dart';
import '../models/photo_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Place place;

  PlaceScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color(0xffd7ae9c);
    var buttonColor = const Color(0xff795548);
    List<Marker> allMarkers = [];
    allMarkers.add(Marker(
        markerId: const MarkerId("Location Marker"),
        draggable: false,
        position: LatLng(
            double.parse(place.latitude), double.parse(place.longitude))));

    var _initialCameraPosition = CameraPosition(
        target:
            LatLng(double.parse(place.latitude), double.parse(place.longitude)),
        zoom: 15);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text(place.name, style: const TextStyle(fontSize: 26)),
        ),
        backgroundColor: primaryColor,
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/marker.png',
                width: 22,
                height: 22,
              ),
              Text(place.formattedAddress,
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.00),
            child: Text("Gallery",
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          FutureBuilder(
            future: httpService.getPhotos(id: place.id),
            builder:
                (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
              if (snapshot.hasData) {
                List<Photo>? photos = snapshot.data;
                if (photos != null) {
                  return SizedBox(
                      height: 200,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: photos
                            .map(
                              (Photo photo) => Image.network(
                                photo.prefix != "0"
                                    ? "${photo.prefix}200x200${photo.suffix}"
                                    : "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png",
                                height: 200,
                                width: 200,
                              ),
                            )
                            .toList(),
                      ));
                } else {
                  return const Center(child: LinearProgressIndicator());
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.00),
            child: Text("Location",
                style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          SizedBox(
            height: 350.0,
            width: 350.0,
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              markers: Set.from(allMarkers),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
                fixedSize: MaterialStateProperty.all(const Size(160, 46)),
              ),
              child: const Text(
                'View Map',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleMaps(
                            place: place,
                          )),
                );
              }),
        ]));
  }
}
