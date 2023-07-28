import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import '../widgets/alert_message.dart';
import '../widgets/boardView/drag_and_drop_item.dart';
import '../widgets/boardView/drag_and_drop_list.dart';
import '../widgets/connectivity_checker.dart';

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
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Tasks',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Working',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Pause',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      children: <DragAndDropItem>[],
    ),
    DragAndDropList(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 218, 218, 218),
      ),
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.green,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
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
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(3),
                  width: double.infinity,
                  //height: 50,
                  child: Text(task.taskName!)),
            ));
        initialTasks[0].add(task);
      }
      if (task.status == TaskStatus.WORKING.name) {
        contents![1].children.add(DragAndDropItem(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(3),
                  width: double.infinity,
                  //height: 50,
                  child: Text(task.taskName!)),
            ));
        initialTasks[1].add(task);
      }
      if (task.status == TaskStatus.PAUSE.name) {
        contents![2].children.add(DragAndDropItem(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(3),
                  width: double.infinity,
                  //height: 50,
                  child: Text(task.taskName!)),
            ));
        initialTasks[2].add(task);
      }
      if (task.status == TaskStatus.COMPLETE.name) {
        contents![3].children.add(DragAndDropItem(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(3),
                  width: double.infinity,
                  //height: 50,
                  child: Text(task.taskName!)),
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

enum TaskStatus { WORKING, PAUSE, COMPLETE }
