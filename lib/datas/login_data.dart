import 'dart:convert';

import 'package:ansan_church/models/user_model.dart';
import 'package:http/http.dart' as http;

class LoginData {
  static const ROOT = "http://foune76.cafe24.com/login.php";

  static Future<List<User>> getUserLogin(String phone) async {
    try {
      var map = Map<String, dynamic>();
      map['phone'] = phone;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User Login Result : ${response.body}');

      if (response.statusCode == 200) {
        List<User> l = parseResponse(response.body);
        return l;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
