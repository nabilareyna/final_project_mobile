class ArtistModel {
  final String id;
  final String name;
  final String genre;
  final String image;

  ArtistModel({
    required this.id,
    required this.name,
    required this.genre,
    required this.image,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json["id"],
      name: json["name"] ?? "",
      genre: json["genre"] ?? "",
      image: (json['image'] ?? '').toString(),
    );
  }
}
