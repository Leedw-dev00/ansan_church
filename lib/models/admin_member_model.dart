class AdminMember {
  String name;
  String gender;
  String groupName;
  String done;
  String count;

  AdminMember({
    required this.name,
    required this.gender,
    required this.groupName,
    required this.done,
    required this.count,
  });

  factory AdminMember.fromJson(Map<String, dynamic> json) {
    return AdminMember(
      name: json['name'] as String,
      gender: json['gender'] as String,
      groupName: json['groupName'] as String,
      done: json['done'] as String,
      count: json['count'] as String,
    );
  }
}
