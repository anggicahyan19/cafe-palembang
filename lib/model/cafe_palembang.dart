class Cafe {
  final String name;
  final String location;
  final String description;
  final String open;
  final String built;
  final String imageAsset;
  final List<String> imageUrls;
  bool isFavorite;

  Cafe({
    required this.name,
    required this.location,
    required this.description,
    required this.open,
    required this.built,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
  });

}

