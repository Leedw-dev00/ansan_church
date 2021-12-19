class NoticeModel {
  String id;
  String content;
  String date;

  NoticeModel({
    required this.id,
    required this.content,
    required this.date,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
    );
  }
}
