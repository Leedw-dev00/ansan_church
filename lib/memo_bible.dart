import 'package:ansan_church/models/memo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datas/progress_data.dart';
import 'login_page.dart';

class MemoBible extends StatefulWidget {
  const MemoBible({Key? key, required this.like, required this.content})
      : super(key: key);
  final like;
  final content;

  @override
  _MemoBibleState createState() => _MemoBibleState();
}

class _MemoBibleState extends State<MemoBible> {
  ScrollController mainController = ScrollController();
  ScrollController subController = ScrollController();
  List<bool> isOpen = [];
  List<MemoModel> bList = [];

  @override
  void initState() {
    print(controller.user.value.name);
    ProgressData.getProgressMemoList(widget.like, widget.content).then((value) {
      setState(() {
        bList = value;
      });
    });
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
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 5, right: 5),
                              child: Image.asset("assets/back_w.png"))),
                      SizedBox(height: 33),
                      Text(
                        widget.like,
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${widget.like} 진도 메모장 입니다.',
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
                          widget.like,
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: bList.length == 0
                              ? Text("기록된 메모가 없습니다")
                              : ListView.builder(
                                  controller: subController,
                                  itemCount: bList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    isOpen.add(false);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOpen[index] = !isOpen[index];
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 150),
                                          padding: isOpen[index]
                                              ? EdgeInsets.all(20)
                                              : EdgeInsets.only(
                                                  left: 20, right: 20),
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                          child: Column(
                                            mainAxisAlignment: isOpen[index]
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    bList[index].content,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'NanumSquareR',
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        bList[index].memo,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'NanumSquareR',
                                                          fontSize: 14,
                                                        ),
                                                        overflow: isOpen[index]
                                                            ? null
                                                            : TextOverflow
                                                                .ellipsis,
                                                        softWrap: isOpen[index]
                                                            ? true
                                                            : false,
                                                        maxLines: isOpen[index]
                                                            ? null
                                                            : 1,
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Icon(
                                                            isOpen[index]
                                                                ? CupertinoIcons
                                                                    .chevron_up
                                                                : CupertinoIcons
                                                                    .chevron_down,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              isOpen[index]
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        TextEditingController
                                                            _controller =
                                                            TextEditingController();
                                                        _controller.text =
                                                            bList[index].memo;
                                                        Get.dialog(AlertDialog(
                                                          insetPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                bList[index]
                                                                    .content,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'NanumSquareB',
                                                                  color: Colors
                                                                      .black,
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
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _controller,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                    maxLines:
                                                                        14,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "내용",
                                                                      fillColor:
                                                                          Color(
                                                                              0xFFF7F7F7),
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.fromLTRB(
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
                                                                        offset: const Offset(
                                                                            2,
                                                                            2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 20),
                                                                Container(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      ProgressData.putUpdateMemo(
                                                                              bList[index].id,
                                                                              _controller.text)
                                                                          .then((value) {
                                                                        if (value) {
                                                                          Get.back();
                                                                          bList[index].memo =
                                                                              _controller.text;
                                                                          Get.snackbar(
                                                                              "성공",
                                                                              "메모가 수정되었습니다");
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
                                                                          "저장",
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
                                                          ),
                                                        ));
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        width: 310,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF8B90AB),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              '쓰기',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'NanumSquareB',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
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
