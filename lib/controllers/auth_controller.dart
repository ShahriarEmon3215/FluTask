import 'package:flutask/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/connectivity_checker.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  SharedPreferences? prefs;
  Status _status = Status.Uninitialized;
  String? _token;
  bool showLoginPassword = false;
  bool showRegisterPassword = false;
  bool showRegiserConfPassword = false;

  Status? get status => _status;
  String? get token => _token!;

  final String api = 'http://10.0.2.2:2023/api/user';

  initAuthProvider() async {
    prefs = await SharedPreferences.getInstance();
    String? token = await getToken();
    if (token != null) {
      _token = token;

      //var status = prefs!.getBool('isLoggedIn') ?? false;
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
        await prefs!.setString('token', apiResponse['token']);
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }

      if (!apiResponse['success']) {
        _status = Status.Unauthenticated;
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

  Future register(String name, String email, String password,
      String passwordConfirm, BuildContext context) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      final url = "$api/createUser";

      var headers = {"Content-Type": "application/json"};
      var body = {"username": name, "email": email, "password": password};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body);
      var apiResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        CustomAlert().messageAlert(
            message: "Registered successfully, please login now",
            isError: false,
            context: context);
        await Future.delayed(Duration(seconds: 1));
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }

      if (response.statusCode == 422) {
        CustomAlert().messageAlert(
            message: apiResponse['message'], isError: true, context: context);
        _status = Status.Authenticated;
        notifyListeners();
        return false;
      }
    } else {
      CustomAlert().messageAlert(
          message: "No Internet!", isError: true, context: context);
    }

    return false;
  }

  // Future<bool> passwordReset(String email) async {
  //   final url = "$api/forgot-password";

  //   Map<String, String> body = {
  //     'email': email,
  //   };

  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: body,
  //   );

  //   if (response.statusCode == 200) {
  //     notifyListeners();
  //     return true;
  //   }

  //   return false;
  // }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['token']);
    //await storage.setString('name', apiResponse['user']['name']);
  }

  Future<String?>? getToken() async {
    // SharedPreferences? storage = await SharedPreferences.getInstance();
    String? token = prefs!.getString('token');
    return token;
  }

  logOut([bool tokenExpired = false]) async {
    _status = Status.Unauthenticated;
    if (tokenExpired == true) {}
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }

  void toggleShowPassword(String check) {
    if (check == "lp") {
      showLoginPassword = !showLoginPassword;
    }
    if (check == "rp") {
      showRegisterPassword = !showRegisterPassword;
    }
    if (check == "rcp") {
      showRegiserConfPassword = !showRegiserConfPassword;
    }
    notifyListeners();
  }
}
