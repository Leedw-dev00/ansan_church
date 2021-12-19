import 'dart:convert';

import 'package:ansan_church/models/admin_member_model.dart';
import 'package:ansan_church/models/group_absent_model.dart';
import 'package:http/http.dart' as http;

class AdminMemberData {
  static const ROOT = "http://foune76.cafe24.com/admin.php";
  static const MEMBER_ACTION = "member";
  static const GROUP_ACTION = "group";
  static const GROUP_LIST_ACTION = "groupList";
  static const ALL_ACTION = "all";
  static const ALL_LIST_ACTION = "allList";

  static Future<List<AdminMember>> getMember() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = MEMBER_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Admin GetMember Result : ${response.body}');
      if (200 == response.statusCode) {
        List<AdminMember> list = parseResponse(response.body);
        return list;
      } else {
        return <AdminMember>[];
      }
    } catch (e) {
      print(e);
      return <AdminMember>[];
    }
  }

  static Future<List<String>> getGroup(String groupName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GROUP_ACTION;
      map['groupName'] = groupName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetGroup Result : ${response.body}');
      if (200 == response.statusCode) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return [body['count'], body['done']];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<AdminAbsentModel>> getGroupList(String groupName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GROUP_LIST_ACTION;
      map['groupName'] = groupName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetGroupList Result : ${response.body}');
      if (200 == response.statusCode) {
        List<AdminAbsentModel> list = parseAbsentResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<String>> getAll() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetAll Result : ${response.body}');
      if (200 == response.statusCode) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return [body['count'], body['done']];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<AdminAbsentModel>> getAllList() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = ALL_LIST_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User GetAllList Result : ${response.body}');
      if (200 == response.statusCode) {
        List<AdminAbsentModel> list = parseAbsentResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static List<AdminMember> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<AdminMember>((json) => AdminMember.fromJson(json))
        .toList();
  }

  static List<AdminAbsentModel> parseAbsentResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<AdminAbsentModel>((json) => AdminAbsentModel.fromJson(json))
        .toList();
  }
}
