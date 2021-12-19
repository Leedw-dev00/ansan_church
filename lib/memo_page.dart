import 'package:ansan_church/datas/biblename.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'memo_bible.dart';

class Memo extends StatefulWidget {
  const Memo({Key? key}) : super(key: key);

  @override
  _MemoState createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  bool isNew = true;
  BibleName bibleName = BibleName();
  ScrollController mainController = ScrollController();
  ScrollController subController = ScrollController();

  @override
  void initState() {
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
                            '추구 메모',
                            style: TextStyle(
                              fontFamily: 'SCDream7',
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     InkWell(
                          //       onTap: () {
                          //         setState(() {
                          //           isNew = false;
                          //         });
                          //       },
                          //       child: Container(
                          //         width: 50,
                          //         height: 30,
                          //         decoration: BoxDecoration(
                          //             color: isNew
                          //                 ? Color(0xFF99A6DB)
                          //                 : Color(0xFF7B9CD5),
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: Center(
                          //           child: Text(
                          //             '구약',
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontFamily: 'NanumSquareB',
                          //                 fontSize: 15),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(width: 5),
                          //     InkWell(
                          //       onTap: () {
                          //         setState(() {
                          //           isNew = true;
                          //         });
                          //       },
                          //       child: Container(
                          //         width: 50,
                          //         height: 30,
                          //         decoration: BoxDecoration(
                          //             color: isNew
                          //                 ? Color(0xFF7B9CD5)
                          //                 : Color(0xFF99A6DB),
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: Center(
                          //           child: Text(
                          //             '신약',
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontFamily: 'NanumSquareB',
                          //                 fontSize: 15),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        '메모 한 내용을 볼 수 있습니다.',
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
                          '추구 메모장',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView.builder(
                              controller: subController,
                              itemCount: isNew
                                  ? bibleName.newTestament.length
                                  : bibleName.oldTestament.length,
                              itemBuilder: (BuildContext context, int index) {
                                String like = isNew
                                    ? bibleName.newTestament[index]
                                    : bibleName.oldTestament[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(MemoBible(
                                        like: like,
                                        content: "content2",
                                      ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
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
                                          Row(
                                            children: [
                                              Text(
                                                (index + 1)
                                                    .toString()
                                                    .padLeft(2, "0"),
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                like,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Center(
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .right_chevron,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
