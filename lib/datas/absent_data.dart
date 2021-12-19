import 'dart:convert';

import 'package:ansan_church/models/absent_model.dart';
import 'package:http/http.dart' as http;

import '../login_page.dart';

class AbsentData {
  static const ROOT = "http://foune76.cafe24.com/absent.php";
  static const LIST_ACTION = "list";
  static const CHECK_ACTION = "check";

  static Future<List<AbsentModel>> getAbsent() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['memberid'] = controller.user.value.id.toString();
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetAbsent Result : ${response.body}');
      if (200 == response.statusCode) {
        List<AbsentModel> list = parseResponse(response.body);
        return list;
      } else {
        return <AbsentModel>[];
      }
    } catch (e) {
      print(e);
      return <AbsentModel>[];
    }
  }

  static Future<String> checkAbsent(String chartId, String absentId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = CHECK_ACTION;
      map['memberid'] = controller.user.value.id.toString();
      map['chartId'] = chartId;
      map['absentId'] = absentId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User CheckAbsent Result : ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "false";
      }
    } catch (e) {
      print(e);
      return "false";
    }
  }

  static List<AbsentModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<AbsentModel>((json) => AbsentModel.fromJson(json))
        .toList();
  }
}
