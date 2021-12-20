import 'package:ansan_church/group_sub_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
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
        child: SingleChildScrollView(
          controller: mainController,
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
                        '그룹별 실행 현황',
                        style: TextStyle(
                          fontFamily: 'SCDream7',
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '그룹별 실행 현황을 볼 수 있습니다.',
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
                  width: Get.width,
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
                              '그룹별 현황',
                              style: TextStyle(
                                color: Color(0xFF333E72),
                                fontFamily: 'SCDream7',
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                  controller: subController,
                                  itemCount: 10,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(GroupSub(
                                              groupName:
                                                  (index + 1).toString()));
                                        },
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
                                              Text(
                                                '${index + 1} 그룹',
                                                style: TextStyle(
                                                  fontFamily:
                                                  'NanumSquareR',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Icon(
                                                CupertinoIcons
                                                    .right_chevron,
                                                size: 16,
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
