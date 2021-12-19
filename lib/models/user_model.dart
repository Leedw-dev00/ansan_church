class User {
  String id;
  String name;
  String phone;
  String groupName; // 그룹
  String area; // 지역
  String type;  //추구타입(T1, T2, T3)
  String isState; //상태 "심사중" "승인" "거절"
  String isCheck; // 오늘 추구 진도 체크확인 / 추구진도를 체크시 1, default 0 / 매일 12시 0으로 초기화
  String done; // 현재까지 한 추구 진도 수
  String isAdmin;
  String gender;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.groupName,
    required this.area,
    required this.type,
    required this.isState,
    required this.isCheck,
    required this.done,
    required this.isAdmin,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      isCheck: json['isCheck'] as String,
      done: json['done'] as String,
      phone: json['phone'] as String,
      groupName: json['groupName'] as String,
      area: json['area'] as String,
      type: json['type'] as String,
      isState: json['isState'] as String,
      isAdmin: json['isAdmin'] as String,
      gender: json['gender'] as String,
    );
  }
}
