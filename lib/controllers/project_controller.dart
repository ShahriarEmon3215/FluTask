import 'dart:convert';
import 'dart:io';

import 'package:flutask/models/collaboration_request_model.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';
import '../repositories/project_repository.dart';
import '../widgets/alert_message.dart';
import '../widgets/connectivity_checker.dart';

class ProjectController with ChangeNotifier {
  int? projectId = 0;
  List<User> collaborators = [];
  List<Task> tasks = [];
  User? userForAdd = User();
  TextEditingController emailTextController = TextEditingController();
  bool? showSearchedUser = false;

  Future getCollaborators(BuildContext context, int projectId) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        resValue = await ProjectRepository().getContributors(projectId);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        collaborators.clear();
        for (var data in bodyMap['result']) {
          collaborators.add(User.fromJson(data));
        }
        collaborators = collaborators.reversed.toList();
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      } else if (resCode == 400) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      }
      //notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }

  Future getUserByEmail(BuildContext context, String email) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        resValue = await ProjectRepository().getUserByEmail(email);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        userForAdd = User.fromJson(bodyMap['result']);
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: "Not found any user by this email!",
            context: context,
            isError: true);
      } else if (resCode == 400) {
        CustomAlert().messageAlert(
            message: "Failed to load user", context: context, isError: true);
      }
      notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }

  Future createCollaboration(BuildContext context) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        var collaboration = CollaborationRequestModel(
          projectId: this.projectId,
          userId: userForAdd!.id,
          addedDate: DateTime.now().toString(),
        );
        resValue = await ProjectRepository().createCollaboration(collaboration);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        await getCollaborators(context, projectId!);
        CustomAlert().messageAlert(
            message: "${userForAdd!.username} is added to this project.",
            context: context,
            isError: false);
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: bodyMap['message'], context: context, isError: true);
      } else if (resCode == 400) {
        CustomAlert().messageAlert(
            message: "Failed to create collaboration",
            context: context,
            isError: true);
      }
      notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }

  Future getTasks(BuildContext context, int projectId) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        resValue = await ProjectRepository().getTasks(projectId);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        tasks.clear();
        for (var data in bodyMap['result']) {
          tasks.add(Task.fromJson(data));
        }
        tasks = tasks.reversed.toList();
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      } else if (resCode == 400) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      }
      //notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }
}
