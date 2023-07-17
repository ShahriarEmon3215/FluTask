import 'dart:convert';

import 'package:flutask/constants/api_urls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_preference_helper.dart';
import '../models/collaboration_request_model.dart';

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

  Future getContributions(int userId) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {"user_id": userId};

      var response = await http.post(
        Uri.parse(ApiUrl.getContributions),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future getContributors(int projectId) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {"project_id": projectId};

      var response = await http.post(
        Uri.parse(ApiUrl.getContributors),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }

    Future getTasks(int projectId) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {"project_id": projectId};

      var response = await http.post(
        Uri.parse(ApiUrl.getTasksUrl),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }

  Future getUserByEmail(String email) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = {"email": email};

      var response = await http.post(
        Uri.parse(ApiUrl.getUserByEmail),
        headers: headers,
        body: json.encode(body),
      );
      debugPrint(response.body.toString());
      return response;
    } catch (ex) {
      throw ex;
    }
  }

   Future createCollaboration(CollaborationRequestModel collaborationRequestModel) async {
    final String? token = await SharedPreferencesHelper.getToken();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var body = collaborationRequestModel.toJson();

      var response = await http.post(
        Uri.parse(ApiUrl.createCollaborationUrl),
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
