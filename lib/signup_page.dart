import 'package:ansan_church/datas/signup_data.dart';
import 'package:ansan_church/login_page.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  String _Checked = "";


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            extendBody: true,
            body: Container(
              height: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Color(0xFF616CA1),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.offAll(() => LoginPage());

                                print('success');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Icon(
                                  CupertinoIcons.arrow_left_circle_fill,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                            Image.asset("assets/bg.png", width: 120,),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 40, right: 20, bottom: 40, left: 20),
                        width: Get.width,
                        //height:450,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontFamily: 'GmarketSansTTFBold',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '회원가입 후 로그인 해주세요',
                              style: TextStyle(
                                color: Color(0xFF929292),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 35),
                            Text(
                              '이름',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'NanumSquareB',
                              ),
                            ),
                            Container(
                              width: 320,
                              height: 60,
                              padding: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                controller: nameController,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: '이름을 입력해주세요.',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0xFFF5F7F9),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF616CA1), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF616CA1), width: 2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '핸드폰 번호',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'NanumSquareB',
                              ),
                            ),
                            Container(
                              width: 320,
                              height: 60,
                              padding: EdgeInsets.only(top: 10.0),
                              child: TextField(
                                controller: phoneController,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                maxLength: 11,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: '핸드폰 번호를 입력해주세요.',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                  ),
                                  fillColor: Color(0xFFF5F7F9),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF616CA1), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF616CA1), width: 2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              '추구 등급',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'NanumSquareB',
                              ),
                            ),
                            Container(
                              width: 320,
                              padding: EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CustomCheckBox(
                                        value: _isChecked1,
                                        shouldShowBorder: true,
                                        borderColor: Color(0xFF616CA1),
                                        checkedFillColor: Color(0xFF616CA1),
                                        borderRadius: 5,
                                        borderWidth: 1,
                                        checkBoxSize: 16,
                                        onChanged: (val) {
                                          //do your stuff here
                                          setState(() {
                                            _Checked = "T1";
                                            _isChecked1 = val;
                                            _isChecked2 = false;
                                            _isChecked3 = false;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      Text('선택1 (본문)', style:
                                        TextStyle(
                                          fontSize: 12.0
                                        ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      CustomCheckBox(
                                        value: _isChecked2,
                                        shouldShowBorder: true,
                                        borderColor: Color(0xFF616CA1),
                                        checkedFillColor: Color(0xFF616CA1),
                                        borderRadius: 5,
                                        borderWidth: 1,
                                        checkBoxSize: 16,
                                        onChanged: (val) {
                                          //do your stuff here
                                          setState(() {
                                            _Checked = "T2";
                                            _isChecked1 = false;
                                            _isChecked2 = val;
                                            _isChecked3 = false;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      Text('선택2 (본문+각주)', style:
                                      TextStyle(
                                          fontSize: 12.0
                                      ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: <Widget>[
                                      CustomCheckBox(
                                        value: _isChecked3,
                                        shouldShowBorder: true,
                                        borderColor: Color(0xFF616CA1),
                                        checkedFillColor: Color(0xFF616CA1),
                                        borderRadius: 5,
                                        borderWidth: 1,
                                        checkBoxSize: 16,
                                        onChanged: (val) {
                                          //do your stuff here
                                          setState(() {
                                            _Checked = "T3";
                                            _isChecked1 = false;
                                            _isChecked2 = false;
                                            _isChecked3 = val;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 5,),
                                      Text('선택3 (본문+각주+라이프스터디)', style:
                                      TextStyle(
                                          fontSize: 12.0
                                      ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.0,),
                                ],
                              )
                            ),
                            SizedBox(height: 35),
                            InkWell(
                              onTap: () {
                                print(_Checked);
                                if (nameController.text != "" &&
                                    phoneController.text != "" &&
                                    _Checked != "") {
                                  SignUpData.getUserLogin(phoneController.text, nameController.text, _Checked)
                                      .then((value) {
                                    if (value == "true") {
                                      print('success');
                                      Get.off(LoginPage());
                                    } else {
                                      Get.snackbar("회원가입 실패", "입력하신 연락처가 이미 존재하거나 적절히 입력되지 않았습니다\n다시 시도해주세요");
                                    }
                                  });
                                } else {
                                  Get.snackbar("회원가입 실패", "빈칸을 모두 채워주세요");
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xFF616CA1),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Text(
                                    '회원가입',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'NanumSquareEB',
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
