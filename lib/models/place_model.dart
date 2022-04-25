import 'package:flutter/foundation.dart';

class Place {
  final String name;


  Place({
    required this.name,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String,
    );
  }
}