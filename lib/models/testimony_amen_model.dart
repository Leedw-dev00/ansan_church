class TestimonyAmen {
  String id;
  String testimonyId;
  String memberId;

  TestimonyAmen({
    required this.id,
    required this.testimonyId,
    required this.memberId,
  });

  factory TestimonyAmen.fromJson(Map<String, dynamic> json) {
    return TestimonyAmen(
      id: json['id'] as String,
      testimonyId: json['testimonyId'] as String,
      memberId: json['memberId'] as String,
    );
  }
}
