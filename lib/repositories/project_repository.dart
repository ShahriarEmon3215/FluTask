
import 'package:flutask/constants/api_urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_preference_helper.dart';

class ProjectRepository {
  Future getProjectsByUserId(int id) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(
        Uri.parse(ApiUrl.getProjectsByUserId + "$id"),
        headers: headers,
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
