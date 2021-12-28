import 'package:http/http.dart' as http;

class LifeStudyData {
  static const ROOT = "http://foune76.cafe24.com/lifestudy.php";
  static const UPDATE_ACTION = "update";
  static const UPDATE_FOOT_ACTION = "footnote";

  static Future<String> updateLifeStudy(
      String content, String url, String url2, String date) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_ACTION;
      map['content'] = content;
      map['date'] = date;
      map['url'] = url;
      map['url2'] = url2;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User updateLifeStudy Result : ${response.body}');
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

  static Future<String> updateFootNote(String content, String date) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_FOOT_ACTION;
      map['content'] = content;
      map['date'] = date;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('User FootNote Result : ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "false";
      }
    }catch(e){
      print(e);
      return "false";
    }
  }
}
