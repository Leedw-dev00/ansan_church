import 'package:get/get.dart';

class UserGetX {
  int id;
  String name;
  String phone;
  String groupName; // 그룹
  String area; // 지역
  String type;  // 추구타입(T1, T2, T3)
  String isState; //상태 "심사중" "승인" "거절"
  int isCheck; // 오늘 추구 진도 체크확인 / 추구진도를 체크시 1, default 0 / 매일 12시 0으로 초기화
  int done; // 현재까지 한 추구 진도 수
  int isAdmin;
  String gender;

  UserGetX({
    required int id,
    required String name,
    required String phone,
    required String groupName,
    required String area,
    required String type,
    required String isState,
    required int isCheck,
    required int done,
    required int isAdmin,
    required String gender,
  })  : this.id = id,
        this.name = name,
        this.phone = phone,
        this.groupName = groupName,
        this.area = area,
        this.type = type,
        this.isState = isState,
        this.isCheck = isCheck,
        this.done = done,
        this.isAdmin = isAdmin,
        this.gender = gender;
}

class ReactiveController extends GetxController {
  var user = new UserGetX(
    id: 0,
    name: 'None',
    phone: 'None',
    groupName: "0",
    area: "0",
    type: "None",
    isState: 'None',
    isCheck: 0,
    done: 0,
    isAdmin: 0,
    gender: "",
  ).obs;

  change({
    required int id,
    required String name,
    required String phone,
    required String groupName,
    required String area,
    required String type,
    required String isState,
    required int isCheck,
    required int done,
    required int isAdmin,
    required String gender,
  }) {
    user.update((val) {
      val?.id = id;
      val?.name = name;
      val?.phone = phone;
      val?.groupName = groupName;
      val?.area = area;
      val?.type = type;
      val?.isState = isState;
      val?.isCheck = isCheck;
      val?.done = done;
      val?.isAdmin = isAdmin;
      val?.gender = gender;
    });
  }
}
