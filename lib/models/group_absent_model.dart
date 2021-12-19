class AdminAbsentModel {
  String name;
  String gender;
  String groupName = "";
  String count;

  AdminAbsentModel({
    required this.name,
    required this.gender,
    required this.count,
    this.groupName = "",
  });

  factory AdminAbsentModel.fromJson(Map<String, dynamic> json) {
    return AdminAbsentModel(
      name: json['name'] as String,
      gender: json['gender'] as String,
      count: json['count'] as String,
      groupName: json['groupName'] == null ? "" : json['groupName'] as String,
    );
  }
}
