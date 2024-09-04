import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

final String url = 'https://staging.chinesepod.com/api/v1/entrance/login';
final String CPODAPI = 'https://www.chinesepod.com/api/v1/';

class CpodServer {
  String _apiKey;

  String get msg => 'Hello World';
  // [200, 2de0cda42cc79b30ab6aa914e16b8031] or [401, null]

  String get apiKey => _apiKey;

  set apiKey(String key) {
    _apiKey = key;
  }
// https://staging.chinesepod.com/swagger#/Entrance/post__api_v1_entrance_login

  Future login({String email, String password}) async {
    print('log me in');

    print(email);
    print(password);

    var response = await http.post(url, body: {
      'emailAddress': email,
      'password': password,
      'rememberMe': 'false'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(response.body.runtimeType);

    String apiKey;
    var statusCode = response.statusCode;

    if (statusCode == 200) {
      var rsp = json.decode(response.body);
      apiKey = rsp['token'];
      /*
      var setCookie = response.headers['set-cookie'];
      var cookie = setCookie.split(';');
      var CPODSESSID = cookie[0];
      if (CPODSESSID.startsWith('CPODSESSID=')) {
        int p = CPODSESSID.indexOf('=');
        if (p != -1) {
          apiKey = CPODSESSID.substring(p + 1);
        }
      }*/

    }

    return Future.value([statusCode, apiKey]);
  }

  Future getWords() async {
    var url = CPODAPI + 'vocabulary/words';

    var content = 'haha';

    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: " Bearer $_apiKey"},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      content = response.body;
    }

    return Future.value([statusCode, content]);
  }

  Future geStudiedLessons() async {
    var url = CPODAPI + 'dashboard/get-studied-lessons';

    var content = 'haha';

    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $_apiKey'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      content = response.body;
    }

    return Future.value([statusCode, content]);
  }

  Future geLessonVoca(String lessonID) async {
    var url = CPODAPI + 'lessons/get-vocab?lessonId=$lessonID';

    var content;

    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $_apiKey'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      content = response.body;
    }

    return Future.value([statusCode, content]);
  }
}
