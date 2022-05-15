import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../services/http_service.dart';

class ImageWidget extends StatelessWidget {
  final HttpService httpService = HttpService();
  var id;

  ImageWidget({Key? key, required this.id}) : super(key: key);

  late final Future<List<Photo>> _future = httpService.getOnePhoto(id: id);

  @override
  @override
  Widget build(context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.hasData) {
            List<Photo>? photos = snapshot.data;
            if (photos != null) {
              if (photos.isEmpty) {
                return Image.network(
                  "https://vignette2.wikia.nocookie.net/assassinscreed/images/3/39/Not-found.jpg/revision/latest?cb=20110517171552",
                  width: 200,
                  height: 200,
                );
              } else {
                var prefix = photos[0].prefix;
                var suffix = photos[0].suffix;
                return Image.network(
                  "${prefix}200x200$suffix",
                  width: 200,
                  height: 200,
                );
              }
            } else {
              return Image.network(
                "https://vignette2.wikia.nocookie.net/assassinscreed/images/3/39/Not-found.jpg/revision/latest?cb=20110517171552",
                width: 200,
                height: 200,
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
