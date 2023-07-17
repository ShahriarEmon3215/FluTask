import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskManagerView extends StatefulWidget {
  const TaskManagerView({super.key});

  @override
  State<TaskManagerView> createState() => _TaskManagerViewState();
}

class _TaskManagerViewState extends State<TaskManagerView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  BoardViewController boardViewController = new BoardViewController();
  List<BoardList> _lists = <BoardList>[
    BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: [
        BoardItem(
            onStartDragItem:
                (int? listIndex, int? itemIndex, BoardItemState? state) {},
            onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                int? oldItemIndex, BoardItemState? state) {},
            onTapItem: (int? listIndex, int? itemIndex,
                BoardItemState? state) async {},
            item: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board Item"),
              ),
            ))
      ],
    ),
    BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: [
        BoardItem(
            onStartDragItem:
                (int? listIndex, int? itemIndex, BoardItemState? state) {},
            onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                int? oldItemIndex, BoardItemState? state) {},
            onTapItem: (int? listIndex, int? itemIndex,
                BoardItemState? state) async {},
            item: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board Item"),
              ),
            ))
      ],
    ),
    BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: [
        BoardItem(
            onStartDragItem:
                (int? listIndex, int? itemIndex, BoardItemState? state) {},
            onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                int? oldItemIndex, BoardItemState? state) {},
            onTapItem: (int? listIndex, int? itemIndex,
                BoardItemState? state) async {},
            item: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board Item"),
              ),
            ))
      ],
    ),
    BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: [
        BoardItem(
            onStartDragItem:
                (int? listIndex, int? itemIndex, BoardItemState? state) {},
            onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                int? oldItemIndex, BoardItemState? state) {},
            onTapItem: (int? listIndex, int? itemIndex,
                BoardItemState? state) async {},
            item: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board Item"),
              ),
            ))
      ],
    ),
    BoardList(
      onStartDragList: (int? listIndex) {},
      onTapList: (int? listIndex) async {},
      onDropList: (int? listIndex, int? oldListIndex) {},
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: [
        BoardItem(
            onStartDragItem:
                (int? listIndex, int? itemIndex, BoardItemState? state) {},
            onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                int? oldItemIndex, BoardItemState? state) {},
            onTapItem: (int? listIndex, int? itemIndex,
                BoardItemState? state) async {},
            item: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Board Item"),
              ),
            ))
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: BoardView(
          lists: _lists,
          boardViewController: boardViewController,
        )),
      ),
    );
  }
}
