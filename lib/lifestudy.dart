import 'package:ansan_church/datas/lifestudy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LifeStudy extends StatefulWidget {
  const LifeStudy({Key? key}) : super(key: key);

  @override
  _LifeStudyState createState() => _LifeStudyState();
}

class _LifeStudyState extends State<LifeStudy> {
  final List<String> _year = ['2021', '2022', '2023'];
  String _yearValue = '2022';
  final List<String> _month = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  String _monthValue = '01';
  final List<String> _day = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  String _dayValue = '01';
  TextEditingController contentController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController urlController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5),
                                child: Image.asset("assets/back_w.png"))),
                        SizedBox(height: 33),
                        Text(
                          '라이프스터디 입력',
                          style: TextStyle(
                            fontFamily: 'SCDream7',
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '라이프스터디 관리 페이지 입니다.',
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
                            '라이프스터디',
                            style: TextStyle(
                              color: Color(0xFF333E72),
                              fontFamily: 'SCDream7',
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "날짜",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        flex: 8,
                                        child: Row(
                                          children: [
                                            DropdownButton(
                                              value: _yearValue,
                                              items: _year
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _yearValue = value!;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            DropdownButton(
                                              value: _monthValue,
                                              items: _month
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _monthValue = value!;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            DropdownButton(
                                              value: _dayValue,
                                              items: _day
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(value),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _dayValue = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(flex: 2, child: Text('내용')),
                                      SizedBox(width: 20),
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          controller: contentController,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          maxLines: 6,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "내용을 입력해주세요",
                                            hintStyle: TextStyle(
                                              fontSize: 12,
                                            ),
                                            fillColor: Color(0xFFF7F7F7),
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(flex: 2, child: Text('LS 전체1')),
                                      SizedBox(width: 20),
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          controller: urlController,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "링크 주소를 입력해주세요",
                                            hintStyle: TextStyle(
                                              fontSize: 12,
                                            ),
                                            fillColor: Color(0xFFF7F7F7),
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(flex: 2, child: Text('LS 전체2')),
                                      SizedBox(width: 20),
                                      Expanded(
                                        flex: 8,
                                        child: TextField(
                                          controller: urlController2,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "링크 주소를 입력해주세요",
                                            hintStyle: TextStyle(
                                              fontSize: 12,
                                            ),
                                            fillColor: Color(0xFFF7F7F7),
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10.0, 10.0, 10.0, 12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      String date =
                                          "$_yearValue-$_monthValue-$_dayValue";
                                      LifeStudyData.updateLifeStudy(
                                              contentController.text,
                                              urlController.text,
                                              urlController2.text,
                                              date)
                                          .then((value) {
                                        if (value == "true") {
                                          setState(() {
                                            urlController.text = "";
                                            contentController.text = "";
                                            FocusScope.of(context).unfocus();
                                            Get.snackbar(
                                                "성공", "라이프스터디가 등록되었습니다");
                                          });
                                        } else {
                                          Get.snackbar(
                                              "실패", "라이프스터디 등록을 실패했습니다");
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8B90AB),
                                        borderRadius: BorderRadius.circular(5),
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
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
