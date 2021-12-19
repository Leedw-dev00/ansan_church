import 'package:ansan_church/absent_page.dart';
import 'package:ansan_church/datas/member_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'groupmember_page.dart';
import 'login_page.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int allSuccess = 0;
  int mySuccess = 0;
  double progress = 0;
  int absent = 0;

  @override
  void initState() {
    print(controller.user.value.name);
    MemberData.getDone(controller.user.value.id.toString()).then((value) {
      print(value);
      double avg = double.parse(value[0]);
      int done = int.parse(value[1]);
      int allPro = int.parse(value[2]);
      absent = int.parse(value[3]);
      int currentDay = int.parse(value[4]);
      print(currentDay);

      allSuccess = ((avg / (currentDay == 0 ? avg : currentDay)) * 100).toInt();
      mySuccess =
          ((done / (currentDay == 0 ? done : currentDay)) * 100).toInt();
      progress = (((done / allPro) * 1000).roundToDouble()) / 10;
      print(progress);
      print(allSuccess);

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF616CA1),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      '나의 현황',
                      style: TextStyle(
                        fontFamily: 'SCDream7',
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '나의 진도 현황을 지세히 볼 수 있습니다.',
                      style: TextStyle(
                        color: Color(0xFFE2E2E2),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFF9f9f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                      )),
                  child: Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '나의 현황',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(GroupMember(
                                      group: controller.user.value.groupName,
                                    ));
                                  },
                                  child: new CircularPercentIndicator(
                                    radius: 150.0,
                                    lineWidth: 13.0,
                                    animation: true,
                                    percent: (allSuccess / 100),
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Text(
                                          "전체 성취율",
                                          style: new TextStyle(
                                              fontSize: 11.0,
                                              fontFamily: 'NanumSquareR'),
                                        ),
                                        SizedBox(height: 10),
                                        new Text(
                                          "$allSuccess%",
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
                                        "그룹 전체 성취율",
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
                                ),
                              ),
                              FittedBox(
                                child: new CircularPercentIndicator(
                                  radius: 150.0,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: (mySuccess / 100),
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        "나의 성취율",
                                        style: new TextStyle(
                                            fontSize: 11.0,
                                            fontFamily: 'NanumSquareR'),
                                      ),
                                      SizedBox(height: 10),
                                      new Text(
                                        "$mySuccess%",
                                        style: new TextStyle(
                                            color: Color(0xFF7B9CD5),
                                            fontSize: 31.0,
                                            fontFamily: 'TMONBlack'),
                                      ),
                                    ],
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: new Text(
                                      "나의 성취율",
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                  child: new CircularPercentIndicator(
                                    radius: 150.0,
                                    lineWidth: 13.0,
                                    animation: true,
                                    percent: (progress / 100),
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Text(
                                          "진도율",
                                          style: new TextStyle(
                                              fontSize: 11.0,
                                              fontFamily: 'NanumSquareR'),
                                        ),
                                        SizedBox(height: 10),
                                        new Text(
                                          "$progress%",
                                          style: new TextStyle(
                                              color: Color(0xFFFFC053),
                                              fontSize: 31.0,
                                              fontFamily: 'TMONBlack'),
                                        ),
                                      ],
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: new Text(
                                        "진도율",
                                        style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0XFFFFC053),
                                    backgroundColor: Color(0xFFF8F6F0),
                                  ),
                                ),
                                FittedBox(
                                  child: new CircularPercentIndicator(
                                    radius: 150.0,
                                    lineWidth: 13.0,
                                    animation: true,
                                    percent: absent / 100,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        new Text(
                                          "결석",
                                          style: new TextStyle(
                                              fontSize: 11.0,
                                              fontFamily: 'NanumSquareR'),
                                        ),
                                        SizedBox(height: 10),
                                        new Text(
                                          "$absent일",
                                          style: new TextStyle(
                                              color: Color(0xFFFF7A7A),
                                              fontSize: 31.0,
                                              fontFamily: 'TMONBlack'),
                                        ),
                                      ],
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (absent == 0) {
                                            Get.snackbar("결석", "결석을 하지 않았습니다");
                                          } else {
                                            Get.to(Absent());
                                          }
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF7A7A),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: new Text(
                                              "결석 진도 채우기",
                                              style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0XFFFF7A7A),
                                    backgroundColor: Color(0xFFF8F0F0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
