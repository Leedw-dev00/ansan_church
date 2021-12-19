import 'package:ansan_church/datas/testimony_amen_data.dart';
import 'package:ansan_church/models/testimony_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datas/testimony_data.dart';
import 'login_page.dart';

class Nulim extends StatefulWidget {
  const Nulim({Key? key}) : super(key: key);

  @override
  _NulimState createState() => _NulimState();
}

class _NulimState extends State<Nulim> {
  List<Testimony> _tList = [];
  ScrollController mainController = ScrollController();
  ScrollController subController = ScrollController();

  int pageIndex = 0;
  int pageCount = 1;

  @override
  void initState() {
    print(controller.user.value.name);
    TestimonyData.getAllTestimony("LIMIT 0,20").then((value) {
      setState(() {
        _tList = value;
        print(_tList);
        pageCount = (int.parse(_tList[0].count) ~/ 20) + 1;
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
                            '누림 간증',
                            style: TextStyle(
                              fontFamily: 'SCDream7',
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        '간증 내용을 모두에게 공유 해보세요.',
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
                          '누림 간증',
                          style: TextStyle(
                            color: Color(0xFF333E72),
                            fontFamily: 'SCDream7',
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: _tList.length > 0
                              ? ListView.builder(
                                  controller: subController,
                                  itemCount: _tList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          String testimonyId = _tList[index].id;
                                          String memberid = controller
                                              .user.value.id
                                              .toString();
                                          print(memberid);
                                          getAmen(index, memberid, testimonyId);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 70,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    _tList[index].name,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'NanumSquareB',
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    _tList[index].date,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'NanumSquareR',
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                _tList[index].content,
                                                style: TextStyle(
                                                  fontFamily: 'NanumSquareR',
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Text("간증이 없습니다"),
                        ),
                        Container(
                          height: 30,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: pageCount,
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                int min = (index * 20);
                                return InkWell(
                                    onTap: () async {
                                      pageIndex = index;
                                      TestimonyData.getAllTestimony(
                                              "LIMIT $min, 20")
                                          .then((value) {
                                        setState(() {
                                          _tList = value;
                                          print(_tList);
                                        });
                                      });
                                      subController.animateTo(
                                          subController
                                              .position.minScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.fastOutSlowIn);
                                      setState(() {});
                                    },
                                    child: Text(
                                      "[${index + 1}]",
                                      style: TextStyle(
                                          color: (pageIndex == index)
                                              ? Color(0xFF333E72)
                                              : Color(0xFFB3B7CC)),
                                    ));
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

  getAmen(int index, String memberId, String testimonyId) {
    TestimonyAmenData.getAmen(memberId, testimonyId).then((value) {
      print("value : $value");
      int amen = (value[1] == "null") ? 0 : int.parse(value[1]);
      print(amen);
      Get.dialog(
        AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _tList[index].name,
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _tList[index].content,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/book_i.png",
                            width: 22,
                            height: 22,
                          ),
                          SizedBox(width: 5),
                          Text(
                            amen.toString(),
                            style: TextStyle(
                              color: Color(0xFF8B90AB),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        print(value[0]);
                        if (value[0] == "null") {
                          TestimonyAmenData.putAmen(memberId, testimonyId)
                              .then((value) {
                            if (value != "false") {
                              Get.back(closeOverlays: true);
                              Get.snackbar("아멘", "");
                            }
                          });
                        } else {
                          Get.snackbar("아멘", "이미 아멘을 눌렀습니다");
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        decoration: BoxDecoration(
                          color: value[0] == "null"
                              ? Color(0xFF8B90AB)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            value[0] == "null" ? "아멘" : "완료",
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
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
