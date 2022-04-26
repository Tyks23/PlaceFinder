
class Photo {
  final String prefix;
  final String suffix;

  Photo({
    required this.prefix,
    required this.suffix,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    dynamic photoPrefix = json['prefix'] ?? "0";
    dynamic photoSuffix = json['suffix'] ?? "0";

    return Photo(
      prefix: photoPrefix,
      suffix: photoSuffix,
    );
  }
}