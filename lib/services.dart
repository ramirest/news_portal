import 'dart:convert';
import 'package:http/http.dart' as http;
import 'timeline.dart';

class Services{
  static const ROOT = '<url_from_endpoint>';
  static const _GET_ALL_ACTION = 'GET_ALL';

  static Future<List<Timeline>> getNews() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Response: {response.body}');
      if(response.statusCode == 200){
        List<Timeline> list = parseResponse(response.body);
        return list;
      }
    } catch(e) {
      return List<Timeline>();
    }
  }
}