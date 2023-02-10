
class BeerResponseModel {
  final int id;
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;
  final String imageUrl;

  BeerResponseModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.imageUrl,
  });

  factory BeerResponseModel.fromJson(Map<String, dynamic> json) {
    return BeerResponseModel(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
      firstBrewed: json['first_brewed'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}