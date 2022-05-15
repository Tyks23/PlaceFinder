import 'package:flutter/material.dart';
import 'package:place_finder/screens/place_screen.dart';

import '../services/http_service.dart';
import '../models/place_model.dart';
import '../widgets/imageWidget.dart';

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
    var primaryColor = const Color(0xffd7ae9c);
    var secondaryColor = const Color(0xffEED2C8);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text("$category places in ${location.text}",
            style: const TextStyle(fontSize: 24)),
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
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            elevation: 50,
                            color: secondaryColor,
                            shadowColor: Colors.white,
                            child: SizedBox(
                              height: 325,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      place.formattedAddress,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(top: 20.00),
                                        child: ImageWidget(id: place.id)),
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
