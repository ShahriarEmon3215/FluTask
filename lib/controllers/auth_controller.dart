import 'package:flutask/helpers/shared_preference_helper.dart';
import 'package:flutask/repositories/auth_repository.dart';
import 'package:flutask/widgets/alert_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/enums.dart';
import '../widgets/connectivity_checker.dart';


var authProvider = ChangeNotifierProvider.autoDispose((ref) => AuthProvider());


class AuthProvider with ChangeNotifier {
  SharedPreferences? prefs;
  Status _status = Status.Uninitialized;
  String? _token;
  bool showLoginPassword = false;
  bool showRegisterPassword = false;
  bool showRegiserConfPassword = false;

  Status? get status => _status;
  String? get token => _token!;

  final String api = 'http://10.0.2.2:8080/api/user';

  initAuthProvider() async {
    var isLoggedIn = await SharedPreferencesHelper.getLoginFlag();
    if (isLoggedIn) {
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
    //if(true){
      notifyListeners();
      var response = await AuthRepository().login(email, password);
      print(response.body.toString());
      Map<String, dynamic> apiResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        debugPrint(apiResponse.toString());
        await storeUserData(apiResponse);
        CustomAlert().messageAlert(
            message: apiResponse['message'], isError: false, context: context);

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
      var response = await AuthRepository()
          .register(name, email, password, passwordConfirm);
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

  Future<void> storeUserData(apiResponse) async {
    await SharedPreferencesHelper.setLoginFlag(true);
    await SharedPreferencesHelper.setToken(apiResponse['token']);
    await SharedPreferencesHelper.setLoginUserId(apiResponse['user']['id']);
    await SharedPreferencesHelper.setLoginUserName(
        apiResponse['user']['username']);
    await SharedPreferencesHelper.setEmailAddress(apiResponse['user']['email']);
  }

  Future<String?>? getToken() async {
    String? token = await SharedPreferencesHelper.getToken();
    return token;
  }

  logOut() async {
    await SharedPreferencesHelper.setLoginFlag(false);
    await SharedPreferencesHelper.setToken('');
    _status = Status.Unauthenticated;
    notifyListeners();
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
