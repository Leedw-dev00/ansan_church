import 'dart:convert';

import 'package:ansan_church/models/notice_model.dart';
import 'package:http/http.dart' as http;

class NoticeData {
  static const ROOT = "http://foune76.cafe24.com/notice.php";
  static const LIST_ACTION = "list";
  static const WRITE_ACTION = "write";
  static const UPDATE_ACTION = "update";
  static const DELETE_ACTION = "delete";

  static Future<List<NoticeModel>> getNotice(String limit) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['limit'] = limit;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetNotice Result : ${response.body}');
      if (200 == response.statusCode) {
        List<NoticeModel> list = parseResponse(response.body);
        return list;
      } else {
        return <NoticeModel>[];
      }
    } catch (e) {
      print(e);
      return <NoticeModel>[];
    }
  }

  static Future<String> putNotice(String content) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = WRITE_ACTION;
      map['content'] = content;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User PutNotice Result : ${response.body}');
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

  static Future<String> updateNotice(String content, String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_ACTION;
      map['content'] = content;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User UpdateNotice Result : ${response.body}');
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

  static Future<String> deleteNotice(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_ACTION;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User DeleteNotice Result : ${response.body}');
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

  static List<NoticeModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<NoticeModel>((json) => NoticeModel.fromJson(json))
        .toList();
  }
}
