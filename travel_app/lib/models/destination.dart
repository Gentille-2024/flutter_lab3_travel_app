class Destination {
  final String id;
  final String name;
  final String country;
  final String description;
  final String imageAsset;
  final double rating;
  final double price;
  final String category;
  final bool isFavorite;
  final List<String> highlights;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imageAsset,
    required this.rating,
    required this.price,
    required this.category,
    this.isFavorite = false,
    required this.highlights,
  });
}
