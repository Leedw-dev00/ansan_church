import 'package:ansan_church/adminmode_page.dart';
import 'package:ansan_church/controllers/GetxController.dart';
import 'package:ansan_church/datas/notice_data.dart';
import 'package:ansan_church/models/notice_model.dart';
import 'package:ansan_church/models/progress_chart_model.dart';
import 'package:ansan_church/models/testimony_model.dart';
import 'package:ansan_church/notice_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'datas/progress_data.dart';
import 'datas/testimony_data.dart';
import 'login_page.dart';


final controller = Get.put(ReactiveController());
class Home extends StatefulWidget {
  const Home({Key? key, required this.callback}) : super(key: key);
  final Function(int) callback;

  @override
  _HomeState createState() => _HomeState(callback);
}

class _HomeState extends State<Home> {
  final Function(int) callback;
  _HomeState(this.callback);

  ProgressChart progressChart = ProgressChart(
      id: "0",
      date: "0000-00-00",
      content2: "content2",
      footnote: "footnote",
      lifeStudy: "lifestudy");
  List<Testimony> testimonyList = [];
  List<NoticeModel> noticeList = [];

  bool progressCheck = true;
  String checkDate = "0000-00-00";

  @override
  void initState() {
    print(controller.user.value.name);
    // ProgressData.getProgressCheck(controller.user.value.id.toString(),
    //         DateFormat('yyyy-MM-dd').format(DateTime.now()))
    //     .then((value) {
    //   setState(() {
    //     if(progressChart.content2 == "오늘의 진도가 없습니다") {
    //       progressCheck = true;
    //     }else{
    //       progressCheck = value;
    //     }
    //     // progressCheck = value;
    //   });
    // });
    ProgressData.getProgressMainChart("CURDATE()").then((value) {
      print("value : $value");
      if (value.isEmpty) {
        progressChart = ProgressChart(
            id: "0",
            date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
            content2: "오늘의 진도가 없습니다",
            footnote: "오늘의 각주가 없습니다",
            lifeStudy: "lifestudy");
        setState(() {
          progressCheck = true;
        });
      } else {
        progressChart = value[0];
        ProgressData.getProgressCheck(controller.user.value.id.toString(),
            DateFormat('yyyy-MM-dd').format(DateTime.now()))
            .then((value) {
          setState(() {
            progressCheck = value;
          });
        });
      }
      setState(() {});
    });
    TestimonyData.getMainTestimony().then((value) {
      setState(() {
        testimonyList = value;
      });
    });
    NoticeData.getNotice("LIMIT 1").then((value) {
      setState(() {
        noticeList = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF616CA1),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          controller.user.value.isAdmin == 1
                              ? TextButton(
                                  onPressed: () {
                                    Get.to(AdminMode());
                                  },
                                  child: Text(
                                    '관리자 페이지',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(),
                          TextButton(
                            onPressed: () {
                              _userLogout();
                            },
                            child: Text(
                              '로그아웃',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Church in Ansan',
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        //'안녕하세요, 안산교회 입니다.',
                        '안녕하세요 ${controller.user.value.name} ${controller.user.value.gender}님',
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
                          '오늘의 추구 진도',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 15, left: 20, right: 0),
                                width: 200,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 15,
                                      left: 0,
                                      child: Container(
                                        width: 135,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE8E9EE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (progressChart.id != "1" &&
                                                  progressChart.id != "0") {
                                                int pid =
                                                    int.parse(progressChart.id);
                                                ProgressData
                                                        .getProgressMainChartMove(
                                                            (pid - 1)
                                                                .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    progressChart = value[0];
                                                  });

                                                  ProgressData.getProgressCheck(
                                                          controller
                                                              .user.value.id
                                                              .toString(),
                                                          progressChart.date)
                                                      .then((value) {
                                                    setState(() {
                                                      progressCheck = value;
                                                    });
                                                  });
                                                });
                                              }
                                            },
                                            child: Icon(
                                              CupertinoIcons
                                                  .chevron_left_square_fill,
                                              color: progressChart.id == "1" ||
                                                      progressChart.id == "0"
                                                  ? Color(0xFFB3B7CC)
                                                  : Color(0xFF8B90AB),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${progressChart.date.split("-")[1]}/${progressChart.date.split("-")[2]}",
                                            style: TextStyle(
                                              fontFamily: 'TMONBlack',
                                              color: Color(0xFF616CA1),
                                              fontSize: 23,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              if (progressChart.date !=
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.now())) {
                                                int pid =
                                                    int.parse(progressChart.id);
                                                ProgressData
                                                        .getProgressMainChartMove(
                                                            (pid + 1)
                                                                .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    progressChart = value[0];
                                                  });
                                                  ProgressData.getProgressCheck(
                                                          controller
                                                              .user.value.id
                                                              .toString(),
                                                          progressChart.date)
                                                      .then((value) {
                                                    setState(() {
                                                      progressCheck = value;
                                                    });
                                                  });
                                                });
                                              }
                                            },
                                            child: Icon(
                                              CupertinoIcons
                                                  .chevron_right_square_fill,
                                              color: progressChart.date ==
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(
                                                              DateTime.now())
                                                  ? Color(0xFFB3B7CC)
                                                  : Color(0xFF8B90AB),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // Text('${controller.user.value.type}'),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '오늘의 말씀',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Text(
                                              //   progressChart.content1,
                                              //   style: TextStyle(
                                              //     fontFamily: 'NanumSquareR',
                                              //     fontSize: 15,
                                              //   ),
                                              // ),
                                              // SizedBox(height: 5),
                                              Text(
                                                progressChart.content2,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    controller.user.value.type == 'T1'
                                        ?
                                    Container()
                                        :
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '각주',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // Text(
                                              //   progressChart.content1,
                                              //   style: TextStyle(
                                              //     fontFamily: 'NanumSquareR',
                                              //     fontSize: 15,
                                              //   ),
                                              // ),
                                              // SizedBox(height: 5),
                                              Text(
                                                progressChart.footnote,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    controller.user.value.type == 'T1' || controller.user.value.type == 'T2'
                                        ?
                                    Container()
                                        :
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'LIFE STUDY',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Life Study",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'NanumSquareB',
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .xmark,
                                                              size: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      content: Container(
                                                          height: 500,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFF7F7F7),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius: 5,
                                                                offset:
                                                                    const Offset(
                                                                        2, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Text(
                                                              progressChart
                                                                  .lifeStudy,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                                  // _launchURL(
                                                  //     progressChart.lifestudy);
                                                },
                                                child: Container(
                                                  width: Get.width,
                                                  height: 35,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF7B9CD5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: FittedBox(
                                                    child: Text(
                                                      '라이프 스터디 요약',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NanumSquareEB',
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        _launchURL(progressChart
                                                            .lifeStudyAll);
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        height: 35,
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF7B9CD5),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: FittedBox(
                                                          child: Text(
                                                            'LS 전체1',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'NanumSquareEB',
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 5,),

                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        _launchURL(progressChart
                                                            .lifeStudyAll2);
                                                      },
                                                      child: Container(
                                                        width: 120,
                                                        height: 35,
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF7B9CD5),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: FittedBox(
                                                          child: Text(
                                                            'LS 전체2',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'NanumSquareEB',
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      TextEditingController memoController =
                                          TextEditingController();
                                      ProgressData.getProgressMemo(
                                              controller.user.value.id
                                                  .toString(),
                                              progressChart.id)
                                          .then((value) {
                                        if (value != "false") {
                                          memoController.text = value;
                                        }
                                        Get.dialog(AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${progressChart.content2}",
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareB',
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  CupertinoIcons.xmark,
                                                  size: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Container(
                                            width: 700,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child: TextField(
                                                    controller: memoController,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    maxLines: 14,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "내용",
                                                      fillColor:
                                                          Color(0xFFF7F7F7),
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              10.0,
                                                              10.0),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(2, 2),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () {
                                                      ProgressData
                                                              .putProgressMemo(
                                                                  controller
                                                                      .user
                                                                      .value
                                                                      .id
                                                                      .toString(),
                                                                  progressChart
                                                                      .id,
                                                                  memoController
                                                                      .text)
                                                          .then((value) {
                                                        if (value) {
                                                          Get.back();
                                                          Get.snackbar("성공",
                                                              "메모를 저장했습니다");
                                                        } else {
                                                          Get.snackbar("실패",
                                                              "메모를 저장하지 못했습니다");
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF8B90AB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: FittedBox(
                                                        child: Text(
                                                          "저장",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'NanumSquareB',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 150,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8B90AB),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '메모',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NanumSquareB',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!progressCheck) {
                                        ProgressData.putProgressCheck(
                                                controller.user.value.id
                                                    .toString(),
                                                progressChart.date,
                                                progressChart.id)
                                            .then((value) {
                                          setState(() {
                                            progressCheck = value;
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      width: 150,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: progressCheck
                                            ? Color(0xFFB3B7CC)
                                            : Color(0xFF7B9CD5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            progressCheck ? ''
                                                '체크완료' : '체크',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NanumSquareB',
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          '누림 간증',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  left: 20,
                                ),
                                width: 170,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 15,
                                      child: Container(
                                        width: 75,
                                        height: 13,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE8E9EE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Text(
                                        'Board',
                                        style: TextStyle(
                                          fontFamily: 'TMONBlack',
                                          color: Color(0xFF616CA1),
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              testimonyList.length > 0
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'NEW',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                              color: Color(0xFFFF7A7A),
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                  AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          testimonyList[0].name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NanumSquareB',
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .xmark,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            height: 500,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFF7F7F7),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      const Offset(
                                                                          2, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Text(
                                                                testimonyList[0]
                                                                    .content,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            )),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ),
                                                ),
                                                );
                                              },
                                              child: Text(
                                                testimonyList[0].content,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 15,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                  height: testimonyList.length > 1 ? 10 : 0),
                              testimonyList.length > 1
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'NEW',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                              color: Color(0xFFFF7A7A),
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                          Flexible(
                                            child: InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                  AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          testimonyList[1].name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NanumSquareB',
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .xmark,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            height: 500,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFF7F7F7),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      const Offset(
                                                                          2, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Text(
                                                                testimonyList[1]
                                                                    .content,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            )),
                                                        SizedBox(height: 20),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                testimonyList[1].content,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 15,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                  height: testimonyList.length > 2 ? 10 : 0),
                              testimonyList.length > 2
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'NEW',
                                            style: TextStyle(
                                              fontFamily: 'NanumSquareEB',
                                              fontSize: 15,
                                              color: Color(0xFFFF7A7A),
                                            ),
                                          ),
                                          SizedBox(width: 25),
                                          Flexible(
                                            child: InkWell(
                                              onTap: () {
                                                Get.dialog(
                                                  AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          testimonyList[2].name,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'NanumSquareB',
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .xmark,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Container(
                                                        height: 500,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFF7F7F7),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      2, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(
                                                            testimonyList[2]
                                                                .content,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                testimonyList[2].content,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 15,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      String name =
                                          "${controller.user.value.name} ${controller.user.value.gender}";
                                      TextEditingController contentController =
                                          TextEditingController();
                                      Get.dialog(AlertDialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              name,
                                              style: TextStyle(
                                                fontFamily: 'NanumSquareB',
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                CupertinoIcons.xmark,
                                                size: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Container(
                                          width: 500,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child: TextField(
                                                    controller:
                                                        contentController,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    maxLines: 14,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "내용",
                                                      fillColor:
                                                          Color(0xFFF7F7F7),
                                                      filled: true,
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              10.0,
                                                              10.0),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(2, 2),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (contentController
                                                              .text !=
                                                          "") {
                                                        TestimonyData.putTestimony(
                                                                controller.user
                                                                    .value.id
                                                                    .toString(),
                                                                contentController
                                                                    .text,
                                                                name)
                                                            .then((value) {
                                                          if (value) {
                                                            Get.back();
                                                            Get.snackbar("성공",
                                                                "간증을 저장했습니다");
                                                            setState(() {
                                                              testimonyList.insert(
                                                                  0,
                                                                  Testimony(
                                                                      id: testimonyList
                                                                          .last
                                                                          .id,
                                                                      content:
                                                                          contentController
                                                                              .text,
                                                                      memberId: controller
                                                                          .user
                                                                          .value
                                                                          .id
                                                                          .toString(),
                                                                      date: DateTime
                                                                              .now()
                                                                          .toString(),
                                                                      name: controller
                                                                          .user
                                                                          .value
                                                                          .name,
                                                                      count:
                                                                          ''));
                                                            });
                                                          } else {
                                                            Get.snackbar("실패",
                                                                "간증을 저장하는데 실패했습니다");
                                                          }
                                                        });
                                                      } else {
                                                        Get.snackbar(
                                                            "실패", "내용을 입력해주세요");
                                                      }
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF8B90AB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: FittedBox(
                                                        child: Text(
                                                          "저장",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'NanumSquareB',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      width: 150,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8B90AB),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '글쓰기',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NanumSquareB',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.callback(3);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      width: 150,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8B90AB),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '더보기',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NanumSquareB',
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          '공지 사항',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoticeUser()),
                            );
                            print('success');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 20, right: 0),
                                  width: 330,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 15,
                                        child: Container(
                                          width: 75,
                                          height: 13,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8E9EE),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Notice',
                                              style: TextStyle(
                                                fontFamily: 'TMONBlack',
                                                color: Color(0xFF616CA1),
                                                fontSize: 23,
                                              ),
                                            ),
                                            Text(
                                              noticeList.length == 0
                                                  ? ""
                                                  : noticeList[0]
                                                      .date
                                                      .replaceAll("-", "."),
                                              style: TextStyle(
                                                fontFamily: 'NanumSquareR',
                                                color: Color(0xFF616CA1),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    noticeList.length == 0
                                        ? "공지사항이 없습니다"
                                        : noticeList[0].content,
                                    style: TextStyle(
                                      fontFamily: 'NanumSquareR',
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _userLogout() {
    _setAutoLogin();
    controller.change(
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
    );

    Get.offAll(LoginPage());
  }

  _setAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("autoLogin", "").then((value) => print(value));
  }

  void _launchURL(String url) async => await canLaunch(url)
      ? await launch(url)
      : Get.snackbar("오류", "주소를 열지 못했습니다");
}
