class MemoModel {
  String id;
  String memberId;
  String chartId;
  String memo;
  String content;

  MemoModel({
    required this.id,
    required this.memberId,
    required this.chartId,
    required this.memo,
    required this.content,
  });

  factory MemoModel.fromJson(Map<String, dynamic> json) {
    return MemoModel(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      chartId: json['chartId'] as String,
      memo: json['memo'] as String,
      content: json['content'] as String,
    );
  }
}
