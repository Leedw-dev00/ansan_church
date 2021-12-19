import 'dart:convert';

import 'package:ansan_church/models/testimony_model.dart';
import 'package:http/http.dart' as http;

class TestimonyData {
  static const ROOT = "http://foune76.cafe24.com/testimony.php";
  static const LIST_ACTION = "list";
  static const WRITE_ACTION = "write";

  static Future<List<Testimony>> getAllTestimony(String limit) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['limit'] = limit;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User AllTestimony Result : ${response.body}');
      if (200 == response.statusCode) {
        List<Testimony> list = parseResponse(response.body);
        return list;
      } else {
        return <Testimony>[];
      }
    } catch (e) {
      print(e);
      return <Testimony>[];
    }
  }

  static Future<List<Testimony>> getMainTestimony() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['limit'] = "LIMIT 3";
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User MainTestimony Result : ${response.body}');
      if (200 == response.statusCode) {
        List<Testimony> list = parseResponse(response.body);
        return list;
      } else {
        return <Testimony>[];
      }
    } catch (e) {
      print(e);
      return <Testimony>[];
    }
  }

  static Future<bool> putTestimony(
      String memberId, String content, String name) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = WRITE_ACTION;
      map['memberid'] = memberId;
      map['content'] = content;
      map['name'] = name;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User TestimonyWrite Result : ${response.body}');
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

  static List<Testimony> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Testimony>((json) => Testimony.fromJson(json)).toList();
  }
}
