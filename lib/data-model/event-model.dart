class EventClass {
  final int id;
  final String title;
  final String description;
  final String banner_image;
  final String date_time;
  final String organiser_name;
  final String organiser_icon;
  final String venue_name;
  final String venue_city;
  final String venue_country;

  EventClass(
      {required this.id,
      required this.title,
      required this.description,
      required this.banner_image,
      required this.date_time,
      required this.organiser_name,
      required this.organiser_icon,
      required this.venue_name,
      required this.venue_city,
      required this.venue_country});

  factory EventClass.fromJson(Map<String, dynamic> json) {
    return EventClass(
        id: json['id'] ?? 0,
        title: json['title'] ?? "Default title",
        description: json['description'] ?? "Default Description",
        banner_image: json['banner_image'] ?? "No image",
        date_time: json['date_time'] ?? "Default Date Time",
        organiser_name: json['organiser_name'] ?? "Default name",
        organiser_icon: json['organiser_icon'] ?? "Default icon",
        venue_name: json['venue_name'] ?? "Default venue name",
        venue_city: json['venue_city'] ?? "Default city",
        venue_country: json['venue_country'] ?? "Default country");
  }
}
