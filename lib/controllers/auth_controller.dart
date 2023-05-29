import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../widgets/notification_text.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  String? _token;
  String? userRole = "";
  NotificationText? _notification = NotificationText('');

  Status? get status => _status;
  String? get token => _token!;
  NotificationText? get notification =>
      _notification ?? NotificationText('adsf');

  final String api = 'http://10.0.2.2:2023/api/user';

  initAuthProvider() async {
    String? token = await getToken();
    if (token != null) {
      _token = token;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _status = Status.Authenticating;
    _notification = NotificationText("Authenticating....");
    notifyListeners();

    var url = "$api/login";

    var headers = {"Content-Type": "application/json"};
    var body = {"email": email, "password": password};

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(response.body);
      _status = Status.Authenticated;
      _token = apiResponse['token'];
      await storeUserData(apiResponse);
      _notification = NotificationText("Login successful.");
      notifyListeners();
      return true;
    }

    if (response.statusCode == 401) {
      _status = Status.Unauthenticated;
      _notification = NotificationText('Invalid email or password.');
      notifyListeners();
      return false;
    }

    _status = Status.Unauthenticated;
    _notification = NotificationText('Server error.');
    notifyListeners();
    return false;
  }

  Future<Map> register(String name, String email, String password,
      String passwordConfirm) async {
    final url = "$api/createUser";

    Map<String, dynamic> result = {
      "success": false,
      "message": 'Unknown error.'
    };

    var headers = {"Content-Type": "application/json"};
    var body = {"username": name, "email": email, "password": password};

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      _notification = NotificationText(
          'Registration successful, please log in.',
          type: 'info');
      notifyListeners();
      result['success'] = true;
      return result;
    }
    debugPrint(response.body);
    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 422) {
      result['message'] = apiResponse['error'];
      _notification = NotificationText(apiResponse['error'], type: 'info');
      notifyListeners();
      return result;
    }

    return result;
  }

  Future<bool> passwordReset(String email) async {
    final url = "$api/forgot-password";

    Map<String, String> body = {
      'email': email,
    };

    final response = await http.post(
      Uri.parse(url),
      body: body,
    );

    if (response.statusCode == 200) {
      _notification = NotificationText('Reset sent. Please check your inbox.',
          type: 'info');
      notifyListeners();
      return true;
    }

    return false;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['token']);
    //await storage.setString('name', apiResponse['user']['name']);
  }

  Future<String?>? getToken() async {
    SharedPreferences? storage = await SharedPreferences.getInstance();
    String? token = storage.getString('token');
    return token;
  }

  logOut([bool tokenExpired = false]) async {
    _status = Status.Unauthenticated;
    if (tokenExpired == true) {
      _notification = NotificationText('Session expired. Please log in again.',
          type: 'info');
    }
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

  setUserRole(String? value) {
    userRole = value;
    notifyListeners();
  }
}
