import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'datas/member_data.dart';
import 'models/user_model.dart';

class ApprovalSub extends StatefulWidget {
  const ApprovalSub({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _ApprovalSubState createState() => _ApprovalSubState(user);
}

class _ApprovalSubState extends State<ApprovalSub> {
  final User user;
  _ApprovalSubState(this.user);

  final _valueList = ['추구 그룹을 선택하세요', '1그룹', '2그룹', '3그룹', '4그룹', '5그룹', '6그룹', '7그룹', '8그룹', '9그룹', '10그룹'];
  String _selectedValue = '추구 그룹을 선택하세요';

  bool shouldCheck = false;
  bool man = false;
  bool woman = false;
  TextEditingController groupController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "이름",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 8,
                  child: Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'NanumSquareB',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '연락처',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 8,
                  child: Text(
                    user.phone.substring(0, 3) +
                        "-" +
                        user.phone.substring(3, 7) +
                        "-" +
                        user.phone.substring(7),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'NanumSquareB',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(flex: 2, child: Text('추구그룹', style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),)),
                SizedBox(width: 20),
                Expanded(
                  flex: 8,
                  child: DropdownButtonFormField<String>(
                    value: _selectedValue,
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedValue = newValue!;
                      });
                      print(_selectedValue);
                    },
                    items: <String>[
                      '추구 그룹을 선택하세요',
                      '1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
                      '11','12','13','14','15','16','17','18','19','20',
                      '21','22','23','24','25','26','27','28','29','30',
                      '31','32','33','34','35','36','37','38','39','40',
                      '41','42','43','44','45','46','47','48','49','50',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value 그룹'),
                      );
                    }).toList(),



                  )

                  // TextField(
                  //   controller: groupController,
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //   ),
                  //   decoration: InputDecoration(
                  //     border: InputBorder.none,
                  //     hintText: "추구 그룹명을 입력 해주세요.",
                  //     hintStyle: TextStyle(
                  //       fontSize: 12,
                  //     ),
                  //     fillColor: Color(0xFFF7F7F7),
                  //     filled: true,
                  //     contentPadding:
                  //         EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                  //   ),
                  // ),
                ),
              ],
            ),
            SizedBox(height: 20),

            //지역

            // Row(
            //   children: [
            //     Expanded(flex: 2, child: Text('지역')),
            //     SizedBox(width: 20),
            //     Expanded(
            //       flex: 8,
            //       child: TextField(
            //         controller: areaController,
            //         style: TextStyle(
            //           fontSize: 15,
            //         ),
            //         decoration: InputDecoration(
            //           border: InputBorder.none,
            //           hintText: "지역명을 입력 해주세요.",
            //           hintStyle: TextStyle(
            //             fontSize: 12,
            //           ),
            //           fillColor: Color(0xFFF7F7F7),
            //           filled: true,
            //           contentPadding:
            //               EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20),
            Row(
              children: [
                Expanded(flex: 2, child: Text('관리자')),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 35,
                    height: 40,
                    child: CustomCheckBox(
                      value: shouldCheck,
                      shouldShowBorder: true,
                      borderColor: Color(0xFF616CA1),
                      checkedFillColor: Color(0xFF616CA1),
                      borderRadius: 5,
                      borderWidth: 1,
                      checkBoxSize: 16,
                      onChanged: (val) {
                        //do your stuff here
                        setState(() {
                          shouldCheck = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(flex: 6, child: Container())
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(flex: 2, child: Text('성별')),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 40,
                        child: CustomCheckBox(
                          value: man,
                          shouldShowBorder: true,
                          borderColor: Color(0xFF616CA1),
                          checkedFillColor: Color(0xFF616CA1),
                          borderRadius: 5,
                          borderWidth: 1,
                          checkBoxSize: 16,
                          onChanged: (val) {
                            //do your stuff here
                            setState(() {
                              man = val;
                              woman = false;
                            });
                          },
                        ),
                      ),
                      Text("남"),
                      Container(
                        width: 35,
                        height: 40,
                        child: CustomCheckBox(
                          value: woman,
                          shouldShowBorder: true,
                          borderColor: Color(0xFF616CA1),
                          checkedFillColor: Color(0xFF616CA1),
                          borderRadius: 5,
                          borderWidth: 1,
                          checkBoxSize: 16,
                          onChanged: (val) {
                            //do your stuff here
                            setState(() {
                              woman = val;
                              man = false;
                            });
                          },
                        ),
                      ),
                      Text("여"),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: Container())
              ],
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                String gender = man ? "형제" : "자매";
                if (_selectedValue != "추구 그룹을 선택하세요") {  //   && areaController.text != ""
                  MemberData.checkUser(user.id, _selectedValue,
                          areaController.text, shouldCheck, gender)
                      .then((value) {
                    if (value) {
                      Get.back(result: true);
                      Get.snackbar("성공", "회원정보가 변경되었습니다");
                    } else {
                      Get.snackbar("실패", "승인에 실패했습니다");
                    }
                  });
                } else {
                  Get.snackbar("실패", "빈칸을 채워주세요");
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(0xFF8B90AB),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    "저장",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'NanumSquareB',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
