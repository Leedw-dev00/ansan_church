import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'datas/admin_member_data.dart';
import 'models/group_absent_model.dart';

class AllMode extends StatefulWidget {
  const AllMode({Key? key}) : super(key: key);

  @override
  _AllModeState createState() => _AllModeState();
}

class _AllModeState extends State<AllMode> {
  int allMember = 0;
  int doMember = 0;
  List<AdminAbsentModel> absent = [];

  @override
  void initState() {
    AdminMemberData.getAll().then((value) {
      setState(() {
        allMember = int.parse(value[0]);
        doMember = int.parse(value[1]);
      });
    });
    AdminMemberData.getAllList().then((value) {
      setState(() {
        absent = value;
        print(value);
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
                        '전체 실행 현황',
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '전체 실행 현황을 볼 수 있습니다.',
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
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '전체 실행 현황',
                              style: TextStyle(
                                color: Color(0xFF333E72),
                                fontFamily: 'SCDream7',
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new CircularPercentIndicator(
                                  radius: 150.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: 1,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        "참여자",
                                        style: new TextStyle(
                                            fontSize: 11.0,
                                            fontFamily: 'NanumSquareR'),
                                      ),
                                      SizedBox(height: 10),
                                      new Text(
                                        "$allMember명",
                                        style: new TextStyle(
                                            color: Color(0xFF616CA1),
                                            fontSize: 31.0,
                                            fontFamily: 'TMONBlack'),
                                      ),
                                    ],
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: new Text(
                                      "참여자 수",
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Color(0XFF616CA1),
                                  backgroundColor: Color(0xFFF0F2F8),
                                ),
                                new CircularPercentIndicator(
                                  radius: 150.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent:
                                      allMember == 0 ? 0 : doMember / allMember,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        "전체 실행율",
                                        style: new TextStyle(
                                            fontSize: 11.0,
                                            fontFamily: 'NanumSquareR'),
                                      ),
                                      SizedBox(height: 10),
                                      new Text(
                                        allMember == 0
                                            ? "0%"
                                            : "${((doMember / allMember) * 100).round()}%",
                                        style: new TextStyle(
                                            color: Color(0XFF7B9CD5),
                                            fontSize: 31.0,
                                            fontFamily: 'TMONBlack'),
                                      ),
                                    ],
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: new Text(
                                      "전체 실행율",
                                      style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Color(0XFF7B9CD5),
                                  backgroundColor: Color(0xFFF0F4F8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '실행율 하향 리스트',
                              style: TextStyle(
                                color: Color(0xFF333E72),
                                fontFamily: 'SCDream7',
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  itemCount: absent.length,
                                  physics: BouncingScrollPhysics(),
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
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${absent[index].name} ${absent[index].gender}",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'NanumSquareR',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                      '${absent[index].groupName} 그룹',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'NanumSquareR',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '${absent[index].count}일 결석',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'NanumSquareB',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFFF7A7A)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
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
