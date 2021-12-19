import 'dart:convert';

import 'package:ansan_church/models/testimony_amen_model.dart';
import 'package:ansan_church/models/testimony_model.dart';
import 'package:http/http.dart' as http;

class TestimonyAmenData {
  static const ROOT = "http://foune76.cafe24.com/testimony_amen.php";
  static const LIST_ACTION = "list";
  static const WRITE_ACTION = "write";

  static Future<List<String>> getAmen(
      String memberId, String testimonyId) async {
    print(memberId);
    print(testimonyId);
    try {
      var map = Map<String, dynamic>();
      map['action'] = LIST_ACTION;
      map['memberid'] = memberId;
      map['testimonyId'] = testimonyId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetAmen Result : ${response.body}');
      if (200 == response.statusCode) {
        Map<String, dynamic> body = jsonDecode(response.body);
        print(body);
        return [
          body['id'] == null ? "null" : body['id'],
          body['count'] == null ? "null" : body['count']
        ];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> putAmen(String memberId, String testimonyId) async {
    print("putAmen");
    try {
      var map = Map<String, dynamic>();
      map['action'] = WRITE_ACTION;
      map['memberid'] = memberId;
      map['testimonyId'] = testimonyId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User PutAmen Result : ${response.body}');
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

  static List<TestimonyAmen> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TestimonyAmen>((json) => Testimony.fromJson(json))
        .toList();
  }
}
