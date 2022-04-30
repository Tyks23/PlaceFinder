
class Place {
  final String id;
  final String name;
  final String address;
  final String formattedAddress;
  final String locality;
  final String latitude;
  final String longitude;
  String prefix;
  String suffix;


  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.formattedAddress,
    required this.locality,
    required this.latitude,
    required this.longitude,
    required this.prefix,
    required this.suffix,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    dynamic placeId = json['fsq_id'] ?? "ID MISSING!!";
    dynamic placeName = json['name'] ?? "Name not available";
    dynamic placeAddress = json['location']['address'] ?? "Address not available";
    dynamic placeFormattedAddress = json['location']['formatted_address'] ?? placeAddress;
    dynamic placeLocality = json['location']['locality'] ?? "0";
    dynamic placeLatitude = json['geocodes']['main']['latitude'] ?? "0";
    dynamic placeLongitude = json['geocodes']['main']['longitude'] ?? "0";
    dynamic photoPrefix = json['prefix'] ?? "0";
    dynamic photoSuffix = json['suffix'] ?? "0";


    return Place(
      id: placeId,
      name: placeName,
      address: placeAddress,
      formattedAddress: placeFormattedAddress,
      locality: placeLocality,
      latitude: placeLatitude.toString(),
      longitude: placeLongitude.toString(),
      prefix: photoPrefix,
      suffix: photoSuffix,
    );
  }
}