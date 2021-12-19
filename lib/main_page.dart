import 'package:ansan_church/jindo_chart.dart';
import 'package:ansan_church/memo_page.dart';
import 'package:ansan_church/mylist.dart';
import 'package:ansan_church/nulim_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;
  DateTime currentBackPressTime = DateTime.now();

  void moveIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    _widgetOptions = [
      MyList(),
      Memo(),
      Home(
        callback: moveIndex,
      ),
      Nulim(),
      JindoChart(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF616CA1),
          unselectedFontSize: 12,
          currentIndex: _selectedIndex, //현재 선택된 Index
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset(
                "assets/graph.png",
                width: 30,
                height: 40,
              ),
              activeIcon: Image.asset(
                "assets/graph_c.png",
                width: 45,
                height: 45,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset(
                "assets/memo.png",
                width: 30,
                height: 40,
              ),
              activeIcon: Image.asset(
                "assets/memo_c.png",
                width: 45,
                height: 45,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset(
                "assets/home.png",
                width: 30,
                height: 40,
              ),
              activeIcon: Image.asset(
                "assets/home_c.png",
                width: 45,
                height: 45,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset(
                "assets/book.png",
                width: 30,
                height: 40,
              ),
              activeIcon: Image.asset(
                "assets/book_c.png",
                width: 45,
                height: 45,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: new Image.asset(
                "assets/chart.png",
                width: 30,
                height: 40,
              ),
              activeIcon: Image.asset(
                "assets/chart_c.png",
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF616CA1),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(milliseconds: 1500)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "뒤로가기를 한번 더 누르면 종료됩니다.", toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
