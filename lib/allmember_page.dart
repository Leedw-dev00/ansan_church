import 'package:ansan_church/datas/admin_member_data.dart';
import 'package:ansan_church/models/admin_member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllMember extends StatefulWidget {
  const AllMember({Key? key}) : super(key: key);

  @override
  _AllMemberState createState() => _AllMemberState();
}

class _AllMemberState extends State<AllMember> {
  List<AdminMember> adminMember = [];

  @override
  void initState() {
    AdminMemberData.getMember().then((value) {
      setState(() {
        adminMember = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF616CA1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              padding:
                                  EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              child: Image.asset("assets/back_w.png"))),
                      SizedBox(height: 33),
                      Text(
                        '회원별 실행 현황',
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '회워별 실행 현황을 볼 수 있습니다.',
                        style: TextStyle(
                          color: Color(0xFFE2E2E2),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFF9f9f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                      )),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('success');
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 30, left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '회원별 실행 현황',
                                style: TextStyle(
                                  color: Color(0xFF333E72),
                                  fontFamily: 'SCDream7',
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: ListView.builder(
                                    itemCount: adminMember.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(1,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "${adminMember[index].name} ${adminMember[index].gender}",
                                                  style: TextStyle(
                                                    fontFamily: 'NanumSquareR',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '${adminMember[index].groupName}그룹',
                                                  style: TextStyle(
                                                    fontFamily: 'NanumSquareR',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '${adminMember[index].done}일 실행',
                                                  style: TextStyle(
                                                    fontFamily: 'NanumSquareB',
                                                    fontSize: 14,
                                                    color: Color(0xFf7B9CD5),
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  adminMember[index].count ==
                                                          "0"
                                                      ? '결석 없음'
                                                      : '${adminMember[index].count}일 결석',
                                                  style: TextStyle(
                                                    fontFamily: 'NanumSquareB',
                                                    fontSize: 14,
                                                    color: Color(0xFfFF7A7A),
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
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
      ),
    );
  }
}
