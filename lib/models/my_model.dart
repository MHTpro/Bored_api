class MainModel {
  final String activity;
  final String type;
  final num participants;
  final num price;
  final String link;
  final num accessibility;

  MainModel({
    required this.accessibility,
    required this.activity,
    required this.link,
    required this.participants,
    required this.price,
    required this.type,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      accessibility: json["accessibility"],
      activity: json["activity"],
      link: json["link"],
      participants: json["participants"],
      price: json["price"],
      type: json["type"],
    );
  }
}
