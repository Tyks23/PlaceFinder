import 'package:flutter/material.dart';

import '../services/http_service.dart';
import '../models/place_model.dart';

class PlacesScreen extends StatelessWidget {
  final HttpService httpService = HttpService();

  var category;

  var location;

   PlacesScreen({Key? key,
    required this.location,
    required this.category,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Places"),
      ),
      body: FutureBuilder(
        future: httpService.getPlaces(location: location, category: category),

        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            List<Place>? places = snapshot.data;
            if (places != null) {
              return ListView(
                children: places
                    .map(
                      (Place place) => ListTile(
                    title: Text(place.name),
                    subtitle: Text(place.name),
                  ),
                )
                    .toList(),
              );
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