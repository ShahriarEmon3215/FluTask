import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../widgets/boardView/drag_and_drop_item.dart';
import '../widgets/boardView/drag_and_drop_list.dart';

class TaskManagerController with ChangeNotifier {
  List<Task> tasks = [];

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
    tasks.forEach((task) {
      if (task.status == null) {
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
      }
      if (task.status == "working") {
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
      }
      if (task.status == "pause") {
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
      }
      if (task.status == "complete") {
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
      }
    });
  }
}
