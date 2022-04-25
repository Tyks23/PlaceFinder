import 'dart:convert';
import 'package:http/http.dart';
import '../models/place_model.dart';

class HttpService {
  final String placesURL =
      "https://api.foursquare.com/v3/places";
  final String apiKey = "fsq35xr8oJ6LCUvHDtteDXuWKTLGJqvLzreyVEKYmjCGTWo=";

  Future<List<Place>> getPlaces( {category, location} ) async {
    String placeQuery ="/search?query=${category.text}&near=${location.text}%2C%20EE";


    Response res =
        await get(Uri.parse(placesURL+placeQuery), headers: {"Authorization": apiKey});

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
  }
}
