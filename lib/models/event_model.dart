class EventModel {
  final String id;
  final String banner;
  final String title;
  final String date;
  final String time;
  final String description;
  final String location;
  final int price;
  final String genre;
  final List<String> lineup;

  EventModel({
    required this.id,
    required this.banner,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    required this.location,
    required this.price,
    required this.genre,
    required this.lineup,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      banner: json['banner'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0).toInt(),
      genre: json['genre'] ?? '',
      lineup: List<String>.from(json['lineup'] ?? []),
    );
  }
}
