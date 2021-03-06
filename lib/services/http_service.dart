import 'dart:convert';
import 'package:http/http.dart';
import '../models/place_model.dart';
import '../models/photo_model.dart';

class HttpService {
  final String placesURL = "https://api.foursquare.com/v3/places";
  final String apiKey = "fsq35xr8oJ6LCUvHDtteDXuWKTLGJqvLzreyVEKYmjCGTWo=";

  Future<List<Place>> getPlaces({category, location}) async {
    String placeQuery = "/search?query=$category&near=${location.text}%2C%20EE";

    try {
      Response res = await get(Uri.parse(placesURL + placeQuery),
          headers: {"Authorization": apiKey});
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body)["results"];

        List<Place> places = body
            .map(
              (dynamic item) => Place.fromJson(item),
            )
            .toList();

        return places;
      } else {
        throw "Unable to retrieve places.";
      }
    } catch (e) {
      List<Place> places = [];

      return places;
    }
  }

  Future<List<Photo>> getOnePhoto({id}) async {
    String photoQuery = "/${id.toString()}/photos?limit=1";
    Response res = await get(Uri.parse(placesURL + photoQuery),
        headers: {"Authorization": apiKey});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Photo> photo = body
          .map(
            (dynamic item) => Photo.fromJson(item),
          )
          .toList();
      return photo;
    } else {
      throw "Unable to retrieve photos.";
    }
  }

  Future<List<Photo>> getPhotos({id}) async {
    String photoQuery = "/$id/photos";

    Response res = await get(Uri.parse(placesURL + photoQuery),
        headers: {"Authorization": apiKey});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Photo> photos = body
          .map(
            (dynamic item) => Photo.fromJson(item),
          )
          .toList();
      return photos;
    } else {
      throw "Unable to retrieve photos.";
    }
  }
}
