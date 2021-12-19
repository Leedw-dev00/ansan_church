import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datas/progress_data.dart';
import 'login_page.dart';
import 'models/progress_chart_model.dart';

class JindoChart extends StatefulWidget {
  const JindoChart({Key? key}) : super(key: key);

  @override
  _JindoChartState createState() => _JindoChartState();
}

class _JindoChartState extends State<JindoChart> {
  bool shouldCheck = false;
  int year = 1;
  int month = 1;
  List<ProgressChart> _pList = [];
  late ScrollController scrollController;

  ScrollController mainController = ScrollController();
  ScrollController subController = ScrollController();

  @override
  void initState() {
    month = DateTime.now().month;
    ProgressData.getProgressAllChart(year.toString(), month.toString())
        .then((value) {
      setState(() {
        _pList = value;
      });
    });
    scrollController =
        ScrollController(initialScrollOffset: (50 * (month - 1)).toDouble());

    subController.addListener(() {
      if (subController.offset == subController.position.minScrollExtent) {
        mainController.animateTo(mainController.position.minScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else if (subController.offset ==
          subController.position.maxScrollExtent) {
        mainController.animateTo(mainController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
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
            controller: mainController,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '진도표',
                            style: TextStyle(
                              fontFamily: 'SCDream7',
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    year = 1;
                                  });
                                  _pList = [];
                                  ProgressData.getProgressAllChart(
                                          year.toString(), month.toString())
                                      .then((value) {
                                    setState(() {
                                      _pList = value;
                                    });
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: year == 1
                                          ? Color(0xFF7B9CD5)
                                          : Color(0xFF99A6DB),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      '1년',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NanumSquareB',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    year = 2;
                                  });
                                  _pList = [];
                                  ProgressData.getProgressAllChart(
                                          year.toString(), month.toString())
                                      .then((value) {
                                    setState(() {
                                      _pList = value;
                                    });
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: year == 2
                                          ? Color(0xFF7B9CD5)
                                          : Color(0xFF99A6DB),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      '2년',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NanumSquareB',
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        '진도 일정을 확인 해보세요.',
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
                  child: Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListView.builder(
                              controller: scrollController,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        month = index + 1;
                                      });
                                      _pList = [];
                                      ProgressData.getProgressAllChart(
                                              year.toString(), month.toString())
                                          .then((value) {
                                        setState(() {
                                          _pList = value;
                                        });
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: month == index + 1
                                              ? Color(0xFF7B9CD5)
                                              : Color(0xFF99A6DB),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}월',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NanumSquareB',
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              controller: subController,
                              itemCount: _pList.length,
                              itemBuilder: (BuildContext context, int index) {
                                String date =
                                    "${_pList[index].date.split('-')[1].replaceAll("0", '')}월 ${_pList[index].date.split('-')[2]}일";
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20, top: 5, bottom: 5),
                                  margin: EdgeInsets.only(bottom: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            1, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Text(
                                              date,
                                              style: TextStyle(
                                                fontFamily: 'NanumSquareR',
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                _pList[index].content2,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
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
                                            width: 35,
                                            height: 40,
                                            child: CustomCheckBox(
                                              value: _pList[index].pDate == ""
                                                  ? false
                                                  : true,
                                              shouldShowBorder: true,
                                              borderColor: Color(0xFF616CA1),
                                              checkedFillColor:
                                                  Color(0xFF616CA1),
                                              borderRadius: 5,
                                              borderWidth: 1,
                                              checkBoxSize: 16,
                                              onChanged: (val) {
                                                if (val) {
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
                                                            "진도 체크",
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
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFF7F7F7),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black26,
                                                                    blurRadius:
                                                                        5,
                                                                    offset:
                                                                        const Offset(
                                                                            2,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text(
                                                                "진도 체크를 하시겠습니까?",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              )),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .grey,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        FittedBox(
                                                                      child:
                                                                          Text(
                                                                        "닫기",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
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
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    ProgressData.putProgressCheck(
                                                                            controller.user.value.id
                                                                                .toString(),
                                                                            _pList[index]
                                                                                .date,
                                                                            _pList[index]
                                                                                .id)
                                                                        .then(
                                                                            (value) {
                                                                      if (value) {
                                                                        ProgressData.getProgressAllChart(year.toString(),
                                                                                month.toString())
                                                                            .then((value) {
                                                                          setState(
                                                                              () {
                                                                            _pList =
                                                                                value;
                                                                          });
                                                                          Get.back();
                                                                          Get.snackbar(
                                                                              "성공",
                                                                              "체크했습니다");
                                                                        });
                                                                      } else {
                                                                        Get.snackbar(
                                                                            "실패",
                                                                            "오류가 났습니다");
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 35,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF8B90AB),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        FittedBox(
                                                                      child:
                                                                          Text(
                                                                        "체크하기",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
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
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
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
}
