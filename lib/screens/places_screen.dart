import 'package:flutter/material.dart';
import 'package:place_finder/screens/place_screen.dart';

import '../services/http_service.dart';
import '../models/place_model.dart';

class PlacesScreen extends StatefulWidget {
  var location;
  var category;

  PlacesScreen({
    Key? key,
    required this.location,
    required this.category,
  }) : super(key: key);

  @override
  _PlacesScreen createState() =>
      _PlacesScreen(location: location, category: category);
}

class _PlacesScreen extends State<PlacesScreen> {
  final HttpService httpService = HttpService();

  var category;
  var location;

  _PlacesScreen({
    required this.location,
    required this.category,
  });

  late final Future<List<Place>> _future =
      httpService.getPlaces(location: location, category: category);

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
                        (Place place) =>
                            InkWell(
                              child: Card(
                                elevation: 50,
                                shadowColor: Colors.white,
                                color: const Color(0xffefd3c8),
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
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Image.network(
                                          place.prefix != "0"
                                              ? "${place.prefix}150x150${place.suffix}"
                                              : "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png",
                                          width: 150,
                                          height: 150,
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
