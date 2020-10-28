import 'dart:convert';

import "package:http/http.dart" show Client;
import 'package:login/src/models/User.dart';

class ApiLogin {
  final String ENDPOINT = "http://127.0.0.1:8888/signup";
  Client http = Client();

  Future<String> validateUser(User user) async {
    final response = await http.post(ENDPOINT,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(user.toJSON()));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
