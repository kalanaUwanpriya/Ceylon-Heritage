class HistoricalPlace {
  final String? id;
  final String name;
  final String destination;
  final String description;
  final String location;
  final String image;

  HistoricalPlace({
    this.id,
    required this.name,
    required this.destination,
    required this.description,
    required this.location,
    required this.image,
  });

  String get placeId =>
      id ??
      name
          .toLowerCase()
          .trim()
          .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
          .replaceAll(RegExp(r'^_+|_+$'), '');
}
