import 'package:ansan_church/datas/absent_data.dart';
import 'package:ansan_church/models/absent_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datas/progress_data.dart';
import 'login_page.dart';

class Absent extends StatefulWidget {
  const Absent({Key? key}) : super(key: key);

  @override
  _AbsentState createState() => _AbsentState();
}

class _AbsentState extends State<Absent> {
  List<AbsentModel> absentList = [];
  List<bool> checkList = [];

  ScrollController mainController = ScrollController();
  ScrollController subController = ScrollController();

  @override
  void initState() {
    AbsentData.getAbsent().then((value) {
      setState(() {
        absentList = value;
        print(value);
      });
    });
    subController.addListener(() {
      if (subController.offset == subController.position.minScrollExtent) {
        mainController.animateTo(mainController.position.minScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                        '결석 진도 채우기',
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '결석한 진도 리스트를 확인하고 체크할 수 있습니다.',
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
                        Text(
                          '결석 진도 리스트',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: absentList.length == 0
                              ? Text("결석 진도가 없습니다")
                              : ListView.builder(
                                  controller: subController,
                                  itemCount: absentList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    checkList.add(false);
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
                                            Text(
                                              absentList[index].content2,
                                              style: TextStyle(
                                                fontFamily: 'NanumSquareR',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    TextEditingController
                                                        memoController =
                                                        TextEditingController();
                                                    ProgressData
                                                            .getProgressMemo(
                                                                controller.user
                                                                    .value.id
                                                                    .toString(),
                                                                absentList[
                                                                        index]
                                                                    .bid)
                                                        .then((value) {
                                                      setState(() {
                                                        memoController.text =
                                                            value;
                                                      });
                                                    });
                                                    Get.dialog(AlertDialog(
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
                                                            absentList[index]
                                                                .content2,
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
                                                              Get.back();
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
                                                        width: 500,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              child: TextField(
                                                                controller:
                                                                    memoController,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                                maxLines: 14,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "내용",
                                                                  fillColor: Color(
                                                                      0xFFF7F7F7),
                                                                  filled: true,
                                                                  contentPadding:
                                                                      EdgeInsets.fromLTRB(
                                                                          10.0,
                                                                          10.0,
                                                                          10.0,
                                                                          10.0),
                                                                ),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
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
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            Container(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  ProgressData.putProgressMemo(
                                                                          controller
                                                                              .user
                                                                              .value
                                                                              .id
                                                                              .toString(),
                                                                          absentList[index]
                                                                              .bid,
                                                                          memoController
                                                                              .text)
                                                                      .then(
                                                                          (value) {
                                                                    if (value) {
                                                                      Get.back();
                                                                      Get.snackbar(
                                                                          "메모",
                                                                          "메모를 저장했습니다");
                                                                    } else {
                                                                      Get.snackbar(
                                                                          "실패",
                                                                          "메모 저장을 실패했습니다");
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
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                      "저장",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
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
                                                  },
                                                  child: Container(
                                                    width: 45,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF8B90AB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        '메모',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'NanumSquareB',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                InkWell(
                                                  onTap: () {
                                                    AbsentData.checkAbsent(
                                                            absentList[index]
                                                                .bid,
                                                            absentList[index]
                                                                .aid)
                                                        .then((value) {
                                                      if (value == "true") {
                                                        setState(() {
                                                          checkList[index] =
                                                              true;
                                                          Get.snackbar("성공",
                                                              "결석 진도를 채웠습니다");
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 45,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: checkList[index]
                                                            ? Color(0xFF7B9CD5)
                                                            : Color(0xFFFF7A7A),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        checkList[index]
                                                            ? "완료"
                                                            : '체크',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'NanumSquareB',
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
