import 'package:http/http.dart' as http;

class SignUpData {
  static const ROOT = "http://foune76.cafe24.com/signup.php";

  static Future<String> getUserLogin(String phone, String name, String type) async {
    try {
      var map = Map<String, dynamic>();
      map['phone'] = phone;
      map['name'] = name;
      map['type'] = type;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User SignUp Result : ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
