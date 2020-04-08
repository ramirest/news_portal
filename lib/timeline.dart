class Timeline {
  int id;
  String title;
  String category;
  String image;
  DateTime date;

  Timeline({this.id, this.title, this.category, this.image, this.date});

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      date: json['date'] as DateTime
    );
  }
}