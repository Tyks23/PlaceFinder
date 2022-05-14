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
    var primaryColor = const Color(0xffd7ae9c);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: const Text("PlaceFinder",
          style: TextStyle(fontSize: 26)),
      ),
      backgroundColor: primaryColor,
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
                            margin: const EdgeInsets.all(30.0),
                            elevation: 50,
                            shadowColor: Colors.white,

                            child: SizedBox(
                              height: 320,
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
                                    Container(
                                      margin: const EdgeInsets.only(top: 20.00),
                                      child: place.suffix != "0"
                                          ? Image.network(
                                              "${place.prefix}200x200${place.suffix}",
                                              width: 200,
                                              height: 200,
                                            )
                                          : const Text("")
                                        ),
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
