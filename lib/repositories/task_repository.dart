import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/api_urls.dart';
import '../helpers/shared_preference_helper.dart';
import 'package:http/http.dart' as http;

class TaskRepository {
    Future updateTaskStatus(int taskID, String? status) async {
    final String? token = await SharedPreferencesHelper.getToken();
    print(token);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {"status": status!};

      var response = await http.post(
        Uri.parse(ApiUrl.updateTaskStatusUrl + taskID.toString()),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}