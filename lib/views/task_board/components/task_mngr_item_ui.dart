import 'package:flutter/material.dart';

class TaskManagerItemUI extends StatelessWidget {
  const TaskManagerItemUI({super.key, required this.taskName});

  final String taskName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      //height: 50,
      child: Text(
        taskName,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}
