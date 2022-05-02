import 'package:flutter/material.dart';
import 'package:place_finder/screens/place_screen.dart';

import '../services/http_service.dart';
import '../models/place_model.dart';

class PlacesScreen extends StatefulWidget {
  var location;
  var category;
  bool photo;

  PlacesScreen({
    Key? key,
    required this.location,
    required this.category,
    required this.photo,
  }) : super(key: key);

  @override
  _PlacesScreen createState() =>
      _PlacesScreen(location: location, category: category, photo: photo);
}

class _PlacesScreen extends State<PlacesScreen> {
  final HttpService httpService = HttpService();

  var category;
  var location;
  bool photo;

  _PlacesScreen({
    required this.location,
    required this.category,
    required this.photo,
  });

  late final Future<List<Place>> _future = httpService.getPlaces(
      location: location, category: category, photos: photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlaceFinder"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            List<Place>? places = snapshot.data;
            if (places != null) {
              if (places.isEmpty) {
                return const Center(child: Text("No places found!"));
              } else {
                return ListView(
                  children: places
                      .map(
                        (Place place) => InkWell(
                          child: Card(
                            elevation: 50,
                            shadowColor: Colors.white,
                            // color: const Color(0xffefd3c8),

                            child: SizedBox(
                              width: 200,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      place.name,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      place.formattedAddress,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    place.suffix != "0"
                                        ? Image.network(
                                            "${place.prefix}150x150${place.suffix}",
                                            width: 150,
                                            height: 150,
                                          )
                                        : const Text("")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlaceScreen(
                                place: place,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }
            } else {
              return const Center(child: LinearProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
