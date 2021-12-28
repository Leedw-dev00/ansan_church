import 'package:ansan_church/main_page.dart';
import 'package:ansan_church/signup_page.dart';
import "package:custom_check_box/custom_check_box.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/GetxController.dart';
import 'datas/login_data.dart';

final controller = Get.put(ReactiveController());

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool shouldCheck = false;
  TextEditingController phoneController = TextEditingController();
  String phone = "";

  _checkAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString("autoLogin") ?? "";
    print(phone);
    if (phone != "") {
      _userLogin(phone);
    }
  }

  @override
  void initState() {
    _checkAutoLogin();

    super.initState();
  }

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
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/bg.png"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 40, right: 20, bottom: 40, left: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 390,
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
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontFamily: 'GmarketSansTTFBold',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '로그인 후 이용해주세요.',
                            style: TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 35),
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
                              autocorrect: true,
                              controller: phoneController,
                              maxLength: 11,
                              keyboardType: TextInputType.number,
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
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
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
                                    Container(
                                      child: Text('자동로그인'),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(SignupPage());
                                    },
                                    child: Text('회원가입')),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              if(phoneController.text != ""){
                                _userLogin(phoneController.text);
                              }else{
                                Get.snackbar("로그인 실패", "로그인에 실패하였습니다\n아이디 또는 비밀번호 확인 후 다시 시도해주세요");
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
                                  '로그인',
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
            )),
      ),
    );
  }

  _userLogin(String phone) {
    Get.dialog(CircularProgressIndicator());
    print(phone);
    if (shouldCheck) {
      print(shouldCheck);
      _setAutoLogin(phone);
    }
    LoginData.getUserLogin(phone).then((user) async {
      print("user : $user");

      if (user.isNotEmpty) {
        await controller.change(
          id: int.parse(user[0].id),
          name: user[0].name,
          phone: user[0].phone,
          groupName: user[0].groupName,
          area: user[0].area,
          type: user[0].type,
          isState: user[0].isState,
          isCheck: int.parse(user[0].isCheck),
          done: int.parse(user[0].done),
          isAdmin: int.parse(user[0].isAdmin),
          gender: user[0].gender,
        );
        print(user[0].isState);
        if (user[0].isState == "승인") {
          Get.offAll(MainPage());
        } else {
          Get.back();
          Get.snackbar('로그인 실패', '아이디가 승인이 되지 않았습니다. 관리자에게 요청하세요');
        }
      } else {
        Get.back();
        Get.snackbar('로그인 실패', '아이디 또는 비밀번호를 확인 후 다시 로그인해주세요');
      }
    });
  }

  _setAutoLogin(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(phone);
    await prefs.setString("autoLogin", phone).then((value) => print(value));
  }
}
