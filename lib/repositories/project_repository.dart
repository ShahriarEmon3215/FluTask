import 'dart:convert';

import 'package:flutask/constants/api_urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_preference_helper.dart';

class ProjectRepository {
  Future getProjects() async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      // var body = {
      //   "Limit": 100,
      //   "Offset": 0,
      //   "ServerPagination": true,
      //   "SortName": "CreatedAt",
      //   "SortOrder": "DESC",
      //   "Parameters": [
      //     {"Name": "JobTitle", "Operat": "cn", "Value": jobTitle}
      //   ]
      // };

      var response = await http.post(
        Uri.parse(ApiUrl.baseUrl),
        headers: headers,
        //body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }
}
