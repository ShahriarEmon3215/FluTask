import 'dart:io';

import 'package:flutask/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  String? _token;
  String? userRole = "";

  Status? get status => _status;
  String? get token => _token!;

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

  Future<bool> login(
      String email, String password, BuildContext context) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      notifyListeners();
      var url = "$api/login";

      var headers = {"Content-Type": "application/json"};
      var body = {"email": email, "password": password};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      Map<String, dynamic> apiResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        await storeUserData(apiResponse);
        CustomAlert().messageAlert(
            message: apiResponse['message'], isError: false, context: context);
        notifyListeners();
        return true;
      }

      if (!apiResponse['success']) {
        notifyListeners();
        CustomAlert().messageAlert(
            message: apiResponse['message'], isError: true, context: context);
        return false;
      }
    } else {
      CustomAlert().messageAlert(
          message: "No Internet!", isError: true, context: context);
    }

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
      notifyListeners();
      result['success'] = true;
      return result;
    }
    debugPrint(response.body);
    Map apiResponse = json.decode(response.body);

    if (response.statusCode == 422) {
      result['message'] = apiResponse['error'];
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
    if (tokenExpired == true) {}
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

  setUserRole(String? value) {
    userRole = value;
    notifyListeners();
  }

  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
