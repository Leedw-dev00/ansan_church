import 'dart:convert';

import 'package:ansan_church/models/admin_member_model.dart';
import 'package:ansan_church/models/user_model.dart';
import 'package:http/http.dart' as http;

class MemberData {
  static const ROOT = "http://foune76.cafe24.com/member.php";
  static const AVG_ACTION = "avg";
  static const TEST_LIST_ACTION = "test_list";
  static const TEST_ACTION = "test";
  static const DELETE_ACTION = "delete";
  static const MEMBER_ACTION = "member";

  static Future<List<String>> getDone(String memberId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = AVG_ACTION;
      map['memberid'] = memberId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User Member Result : ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        return [
          body['count'] == null ? "0" : body['count'],
          body['done'] == null ? "0" : body['done'],
          body['all'] == null ? "0" : body['all'],
          body['absent'] == null ? "0" : body['absent'],
          body['currentDay'] == null ? "0" : body['currentDay']
        ];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<User>> getList() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = TEST_LIST_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User MemberList Result : ${response.body}');

      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<bool> checkUser(
      String id, String group, String area, bool isAdmin, String gender) async {
    print(id + group + area + isAdmin.toString());
    try {
      var map = Map<String, dynamic>();
      map['action'] = TEST_ACTION;
      map['id'] = id;
      map['group'] = group;
      map['area'] = area;
      map['isAdmin'] = isAdmin ? "1" : "0";
      map['gender'] = gender;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User Check Result : ${response.body}');
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

  static Future<bool> deleteUser(String id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = DELETE_ACTION;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User Delete Result : ${response.body}');
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

  static Future<List<AdminMember>> getGroupMember(String group) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = MEMBER_ACTION;
      map['group'] = group;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Admin GetGroupMember Result : ${response.body}');
      if (200 == response.statusCode) {
        List<AdminMember> list = parseGroupResponse(response.body);
        return list;
      } else {
        return <AdminMember>[];
      }
    } catch (e) {
      print(e);
      return <AdminMember>[];
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static List<AdminMember> parseGroupResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<AdminMember>((json) => AdminMember.fromJson(json))
        .toList();
  }
}
