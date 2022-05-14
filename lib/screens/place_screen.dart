import 'package:flutter/material.dart';

import '../services/http_service.dart';
import '../models/place_model.dart';
import '../models/photo_model.dart';

class PlaceScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  final Place place;

  PlaceScreen({Key? key, required this.place}) : super(key: key);

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
        future: httpService.getPhotos(id: place.id),
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.hasData) {
            List<Photo>? photos = snapshot.data;
            if (photos != null) {
              return ListView(
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
