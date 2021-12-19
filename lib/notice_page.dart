import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'datas/notice_data.dart';
import 'models/notice_model.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List<NoticeModel> noticeList = [];

  @override
  void initState() {
    NoticeData.getNotice("").then((value) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '공지 사항',
                            style: TextStyle(
                              fontFamily: 'SCDream7',
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              TextEditingController noticeController =
                                  TextEditingController();
                              Get.dialog(AlertDialog(
                                insetPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat("yyyy.MM.dd")
                                          .format(DateTime.now()),
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        child: TextField(
                                          controller: noticeController,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "내용",
                                            fillColor: Color(0xFFF7F7F7),
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 10.0),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5,
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            NoticeData.putNotice(
                                                    noticeController.text)
                                                .then((value) {
                                              if (value == "true") {
                                                Get.back();
                                                Get.snackbar(
                                                    "성공", "공지사항을 올리는데 성공했습니다");
                                                NoticeData.getNotice("")
                                                    .then((value) {
                                                  setState(() {
                                                    noticeList = value;
                                                  });
                                                });
                                              } else {
                                                Get.snackbar(
                                                    "실패", "공지사항을 올리지 못했습니다");
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF8B90AB),
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xFF7B9CD5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  '글쓰기',
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
                      SizedBox(height: 5),
                      Text(
                        '공지 사항을 관리 할 수 있습니다.',
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
                          '공지 사항',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: noticeList.length == 0
                              ? Text("공지사항이 없습니다")
                              : ListView.builder(
                                  itemCount: noticeList.length,
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
                                              child: Text(
                                                noticeList[index].content,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 14,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    TextEditingController
                                                        notice =
                                                        TextEditingController();
                                                    notice.text =
                                                        noticeList[index]
                                                            .content;
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
                                                            "${noticeList[index].date.split("-")[0]}.${noticeList[index].date.split("-")[1]}.${noticeList[index].date.split("-")[2]}",
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
                                                        width: 500,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              child: TextField(
                                                                controller:
                                                                    notice,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                                maxLines: 8,
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
                                                                  NoticeData.updateNotice(
                                                                          notice
                                                                              .text,
                                                                          noticeList[index]
                                                                              .id)
                                                                      .then(
                                                                          (value) {
                                                                    if (value ==
                                                                        "true") {
                                                                      Get.back();
                                                                      Get.snackbar(
                                                                          "성공",
                                                                          "공지사항이 변경되었습니다");
                                                                      setState(
                                                                          () {
                                                                        noticeList[index].content =
                                                                            notice.text;
                                                                      });
                                                                    } else {
                                                                      Get.snackbar(
                                                                          "실패",
                                                                          "공지사항을 변경하는데 실패했습니다");
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
                                                        '수정',
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
                                                            "삭제",
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
                                                        width: 500,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              noticeList[index]
                                                                  .content,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                                "해당 공지사항을 삭제하시겠습니까?"),
                                                            SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height:
                                                                          35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF8B90AB),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            Text(
                                                                          "아니오",
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
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      NoticeData.deleteNotice(noticeList[index]
                                                                              .id)
                                                                          .then(
                                                                              (value) {
                                                                        if (value ==
                                                                            "true") {
                                                                          Get.back();
                                                                          Get.snackbar(
                                                                              "성공",
                                                                              "공지사항을 삭제했습니다");
                                                                          setState(
                                                                              () {
                                                                            noticeList.removeAt(index);
                                                                          });
                                                                        } else {
                                                                          Get.snackbar(
                                                                              "실패",
                                                                              "삭제하지 못했습니다");
                                                                        }
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height:
                                                                          35,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFF8B90AB),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            Text(
                                                                          "예",
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
                                                    ));
                                                  },
                                                  child: Container(
                                                    width: 45,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFFF7A7A),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        '삭제',
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
                        ),
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
