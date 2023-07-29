import 'dart:convert';
import 'package:flutask/constants/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future login(String email, String password) async {
    try {
      String url = ApiUrl.loginUrl;

      var headers = {"Content-Type": "application/json"};
      var body = {"email": email, "password": password};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future register(String name, String email, String password,
      String passwordConfirm) async {
    try {
      var url = ApiUrl.registerUrl;

      var headers = {"Content-Type": "application/json"};
      var body = {"username": name, "email": email, "password": password};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body);
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
