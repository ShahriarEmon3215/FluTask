
import 'package:flutask/widgets/kAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controllers/task_manager_controller.dart';
import '../widgets/boardView/drag_and_drop_lists.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  TaskManagerController? controller;

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<TaskManagerController>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              kAppBar(
                title: "Tasks",
                showBackButton: true,
                backPressHandler: () {
                  Navigator.pop(context);
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.portraitUp,
                  ]);
                },
              ),
              Expanded(
                  child: DragAndDropLists(
                axis: Axis.horizontal,
                listWidth: 180,
                listPadding: EdgeInsets.all(5),
                children: controller!.contents!,
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
                
              )),
            ],
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem =
          controller!.contents![oldListIndex].children.removeAt(oldItemIndex);
      controller!.contents![newListIndex].children
          .insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = controller!.contents!.removeAt(oldListIndex);
      controller!.contents!.insert(newListIndex, movedList);
    });
  }
}
