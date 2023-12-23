import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutask/helpers/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';
import '../widgets/alert_message.dart';
import '../widgets/connectivity_checker.dart';

var dashboardProvider =
    ChangeNotifierProvider.autoDispose((ref) => DashboardController());

class DashboardController extends ChangeNotifier {
  final List<Color> _colorList = [
    Color.fromRGBO(253, 234, 236, 1),
    Color.fromRGBO(214, 238, 255, 1),
    Color.fromRGBO(243, 228, 255, 1),
    Color.fromRGBO(253, 234, 253, 1),
    Color.fromRGBO(230, 243, 236, 1),
    Color.fromRGBO(189, 255, 223, 1),
    Color.fromRGBO(235, 220, 183, 1),
  ];

  Color getRandomColor() {
    final random = Random();
    Color? color = _colorList[random.nextInt(_colorList.length)];
    return color;
  }

  List<Project> projectList = [];
  Future getProjectList(BuildContext context) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      int? userId = await SharedPreferencesHelper.getLoginUserId();
      var resValue;
      try {
        resValue = await ProjectRepository().getProjectsByUserId(userId);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        projectList.clear();
        for (var data in bodyMap['result']) {
          projectList.add(Project.fromJson(data));
        }
        print(projectList.length);
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      } else if (resCode == 400) {
        CustomAlert().messageAlert(
            message: "Failed to load data", context: context, isError: true);
      }
      notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }

  List contributedProjectList = [];
  Future getContributedProjectsList(BuildContext context) async {
    int? userId = await SharedPreferencesHelper.getLoginUserId();
    var resValue = await ProjectRepository().getContributions(userId);
    var bodyMap = json.decode(resValue.body);
    var resCode = resValue.statusCode;

    if (resCode == 200) {
      contributedProjectList.clear();
      for (var data in bodyMap['result']) {
        contributedProjectList.add(Project.fromJson(data));
      }
      print(contributedProjectList.length);
    } else if (resCode == 401) {
      CustomAlert().messageAlert(
          message: "Failed to load data", context: context, isError: true);
    }
    notifyListeners();
  }
}
