import 'dart:convert';

import 'package:ansan_church/models/memo_model.dart';
import 'package:ansan_church/models/progress_chart_model.dart';
import 'package:http/http.dart' as http;

import '../login_page.dart';

class ProgressData {
  static const ROOT = "http://foune76.cafe24.com/progress.php";
  static const MAIN_ACTION = "main";
  static const MAIN_MOVE_ACTION = "mainMove";
  static const LIST_ACTION = "list";
  static const CHECK_ACTION = "check";
  static const GET_CHECK_ACTION = "getCheck";
  static const GET_MEMO_ACTION = "getmemo";
  static const MEMO_ACTION = "memo";
  static const MEMO_LIST_ACTION = "memoList";
  static const MEMO_UPDATE_ACTION = "memo_update";

  static Future<List<ProgressChart>> getProgressMainChart(String date) async {
    print(date);
    try {
      var map = Map<String, dynamic>();
      map['action'] = MAIN_ACTION;
      map['date'] = date;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressMainChart Result : ${response.body}');
      if (200 == response.statusCode) {
        List<ProgressChart> list = parseResponse(response.body);
        return list;
      } else {
        return <ProgressChart>[];
      }
    } catch (e) {
      return <ProgressChart>[];
    }
  }

  static Future<List<ProgressChart>> getProgressMainChartMove(String id) async {
    print(id);
    try {
      var map = Map<String, dynamic>();
      map['action'] = MAIN_MOVE_ACTION;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressMainChartMove Result : ${response.body}');
      if (200 == response.statusCode) {
        List<ProgressChart> list = parseResponse(response.body);
        return list;
      } else {
        return <ProgressChart>[];
      }
    } catch (e) {
      return <ProgressChart>[];
    }
  }

  static Future<List<ProgressChart>> getProgressAllChart(
      String year, String month) async {
    print(controller.user.value.name);
    print(year);
    print(month);
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['year'] = year == "1" ? "2022" : "2023";
      map['month'] = month;
      map['memberid'] = controller.user.value.id.toString();
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressAllChart Result : ${response.body}');
      if (200 == response.statusCode) {
        List<ProgressChart> list = parseResponse(response.body);
        print(list);
        return list;
      } else {
        return <ProgressChart>[];
      }
    } catch (e) {
      print(e);
      return <ProgressChart>[];
    }
  }

/////////check
  static Future<bool> putProgressCheck(
      String memberId, String date, String id) async {
    print(memberId + " " + date + " " + id);
    try {
      var map = Map<String, dynamic>();
      map['action'] = CHECK_ACTION;
      map['memberid'] = memberId;
      map['date'] = date;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressCheck Result : ${response.body}');
      if (200 == response.statusCode) {
        bool result = false;
        if (response.body == "true") result = true;
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> getProgressCheck(String memberId, String date) async {
    print(date);
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_CHECK_ACTION;
      map['memberid'] = memberId;
      map['date'] = date;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressGetCheck Result : ${response.body}');
      if (200 == response.statusCode) {
        bool result = false;
        if (response.body == "true") result = true;
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//////////memo
  static Future<bool> putProgressMemo(
      String memberId, String chartId, String memo) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = MEMO_ACTION;
      map['memberid'] = memberId;
      map['chartid'] = chartId;
      map['memo'] = memo;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressMemo Result : ${response.body}');
      if (200 == response.statusCode) {
        bool result = false;
        if (response.body == "true") result = true;
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String> getProgressMemo(String memberId, String chartId) async {
    print(memberId);
    print(chartId);
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_MEMO_ACTION;
      map['memberid'] = memberId;
      map['chartid'] = chartId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressGetMemo Result : ${response.body}');
      if (200 == response.statusCode) {
        return response.body == "false" ? "" : response.body;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static Future<List<MemoModel>> getProgressMemoList(
      String like, String content) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = MEMO_LIST_ACTION;
      map['like'] = like;
      map['content'] = content;
      map['memberid'] = controller.user.value.id.toString();
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User ProgressMemo Result : ${response.body}');
      if (200 == response.statusCode) {
        List<MemoModel> list = parseMemoResponse(response.body);
        print(list);
        return list;
      } else {
        return <MemoModel>[];
      }
    } catch (e) {
      print(e);
      return <MemoModel>[];
    }
  }

  static Future<bool> putUpdateMemo(String id, String memo) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = MEMO_UPDATE_ACTION;
      map['id'] = id;
      map['memo'] = memo;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User UpdateMemo Result : ${response.body}');
      if (200 == response.statusCode) {
        bool result = false;
        if (response.body == "true") result = true;
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static List<ProgressChart> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProgressChart>((json) => ProgressChart.fromJson(json))
        .toList();
  }

  static List<MemoModel> parseMemoResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MemoModel>((json) => MemoModel.fromJson(json)).toList();
  }
}
