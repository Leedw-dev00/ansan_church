class AbsentModel {
  String aid;
  String bid;
  String content2;

  AbsentModel({
    required this.aid,
    required this.bid,
    required this.content2,
  });

  factory AbsentModel.fromJson(Map<String, dynamic> json) {
    return AbsentModel(
      aid: json['aid'] as String,
      bid: json['bid'] as String,
      content2: json['content2'] == null ? "" : json['content2'] as String,
    );
  }
}
