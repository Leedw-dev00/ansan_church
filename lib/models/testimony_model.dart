class Testimony {
  String id;
  String content;
  String memberId;
  String date;
  String name;
  String count;

  Testimony({
    required this.id,
    required this.content,
    required this.memberId,
    required this.date,
    required this.name,
    required this.count,
  });

  factory Testimony.fromJson(Map<String, dynamic> json) {
    return Testimony(
      id: json['id'] as String,
      content: json['content'] as String,
      memberId: json['memberId'] as String,
      date: json['date'] as String,
      name: json['name'] as String,
      count: json['count'] as String,
    );
  }
}
