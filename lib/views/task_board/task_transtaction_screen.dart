import 'package:flutask/constants/strings.dart';
import 'package:flutask/widgets/kAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/enums.dart';
import '../../controllers/task_manager_controller.dart';
import '../../models/task_model.dart';
import 'components/boardView/drag_and_drop_lists.dart';

class TasksView extends ConsumerStatefulWidget {
  const TasksView({super.key});

  @override
  ConsumerState<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends ConsumerState<TasksView> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  TaskManagerController? controller;
  bool isDataLoaded = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (!isDataLoaded) {
      controller = ref.read(taskManagerProvider);
      controller!.tasks =
          ModalRoute.of(context)!.settings.arguments as List<Task>;
      controller!.bindTasks();
      isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              kAppBar(
                title: AppStrings.taskBoardScreenTitle,
                showBackButton: true,
                backPressHandler: () async {
                  // await SystemChrome.setPreferredOrientations([
                  //   DeviceOrientation.portraitDown,
                  //   DeviceOrientation.portraitUp,
                  // ]);
                  Navigator.pop(context);
                },
              ),
              Expanded(
                  child: DragAndDropLists(
                axis: Axis.horizontal,
                listWidth: 220,
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
      /// UI item
      var movedItem =
          controller!.contents![oldListIndex].children.removeAt(oldItemIndex);

      /// task item
      var movedTaskItem =
          controller!.initialTasks[oldListIndex].removeAt(oldItemIndex);

      /// UI list
      controller!.contents![newListIndex].children
          .insert(newItemIndex, movedItem);

      /// task list
      controller!.initialTasks[newListIndex]
          .insert(newItemIndex, movedTaskItem);

      if (newListIndex == 1) {
        controller!.updateTaskStatus(
            context, movedTaskItem.id!, TaskStatus.WORKING.name);
      }
      if (newListIndex == 2) {
        controller!.updateTaskStatus(
            context, movedTaskItem.id!, TaskStatus.PAUSE.name);
      }
      if (newListIndex == 3) {
        controller!.updateTaskStatus(
            context, movedTaskItem.id!, TaskStatus.COMPLETE.name);
      }
      if (newListIndex == 0) {
        controller!.updateTaskStatus(context, movedTaskItem.id!, null);
      }
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = controller!.contents!.removeAt(oldListIndex);
      controller!.contents!.insert(newListIndex, movedList);
    });
  }
}
