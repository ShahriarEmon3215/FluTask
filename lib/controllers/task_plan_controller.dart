import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import '../views/task_plan_page.dart';
import '../widgets/alert_message.dart';
import '../widgets/connectivity_checker.dart';

class TaskPlanController extends ChangeNotifier {
  List<Task> tasks = [];
  List<Collaborator> collaborators = [];

  Future updateTaskCollaboration(
      BuildContext context, int tId, String? userName, int? uID) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        resValue =
            await TaskRepository().updateTaskCollaboration(tId, userName, uID);
      } on SocketException {
        CustomAlert().messageAlert(
            message: "Server not found!", context: context, isError: true);
      }

      var bodyMap = json.decode(resValue.body);
      var resCode = resValue.statusCode;

      if (resCode == 200) {
        // CustomAlert()
        //     .messageAlert(message: status, context: context, isError: false);
      } else if (resCode == 401) {
        CustomAlert().messageAlert(
            message: bodyMap['message'], context: context, isError: true);
      } else if (resCode == 400) {
        CustomAlert()
            .messageAlert(message: "Failed", context: context, isError: true);
      }
      notifyListeners();
    } else {
      CustomAlert().messageAlert(
          message: "No internet!", context: context, isError: true);
    }
  }
}
