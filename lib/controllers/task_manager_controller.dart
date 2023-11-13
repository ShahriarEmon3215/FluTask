import 'dart:convert';
import 'dart:io';
import 'package:flutask/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/enums.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import '../widgets/alert_message.dart';
import '../views/task_board/components/boardView/drag_and_drop_item.dart';
import '../views/task_board/components/boardView/drag_and_drop_list.dart';
import '../widgets/connectivity_checker.dart';
import '../views/task_board/components/drag_n_drop_header.dart';
import '../views/task_board/components/task_mngr_item_ui.dart';

var taskManagerProvider = ChangeNotifierProvider((ref) => TaskManagerController());

class TaskManagerController with ChangeNotifier {
  List<Task> tasks = [];
  List<List<Task>> initialTasks = [
    [],
    [],
    [],
    [],
  ];

  List<DragAndDropList>? contents = [
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: DragNDropListHeaderUI(label: AppStrings.taskBoardStringTask),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: DragNDropListHeaderUI(label: AppStrings.taskBoardStringWorking),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: DragNDropListHeaderUI(label: AppStrings.taskBoardStringPause),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: DragNDropListHeaderUI(label: AppStrings.taskBoardStringComplete),
      children: <DragAndDropItem>[],
    ),
  ];

  void bindTasks() {
    contents![0].children.clear();
    contents![1].children.clear();
    contents![2].children.clear();
    contents![3].children.clear();
    initialTasks[0].clear();
    initialTasks[1].clear();
    initialTasks[2].clear();
    initialTasks[3].clear();

    tasks.forEach((task) {
      if (task.status == null || task.status == "") {
        contents![0].children.add(DragAndDropItem(
              child: TaskManagerItemUI(taskName: task.taskName!),
            ));
        initialTasks[0].add(task);
      }
      if (task.status == TaskStatus.WORKING.name) {
        contents![1].children.add(DragAndDropItem(
              child: TaskManagerItemUI(taskName: task.taskName!),
            ));
        initialTasks[1].add(task);
      }
      if (task.status == TaskStatus.PAUSE.name) {
        contents![2].children.add(DragAndDropItem(
              child: TaskManagerItemUI(taskName: task.taskName!),
            ));
        initialTasks[2].add(task);
      }
      if (task.status == TaskStatus.COMPLETE.name) {
        contents![3].children.add(DragAndDropItem(
              child: TaskManagerItemUI(taskName: task.taskName!),
            ));
        initialTasks[3].add(task);
      }
    });
  }

  Future updateTaskStatus(BuildContext context, int tId, String? status) async {
    bool? connectivity = await checkConnectivity();
    if (connectivity) {
      var resValue;
      try {
        resValue = await TaskRepository().updateTaskStatus(tId, status);
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
