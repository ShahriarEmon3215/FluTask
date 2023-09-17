import 'package:flutask/controllers/task_plan_controller.dart';
import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';

@immutable
class ExampleDragAndDrop extends StatefulWidget {
  const ExampleDragAndDrop({super.key});

  @override
  State<ExampleDragAndDrop> createState() => _ExampleDragAndDropState();
}

class _ExampleDragAndDropState extends State<ExampleDragAndDrop>
    with TickerProviderStateMixin {
  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    required Task item,
    required Collaborator collaborator,
  }) {
    controller!.tasks.removeWhere((element) {
      return element.id == item.id;
    });
    setState(() {
      collaborator.items.add(item);
    });
    controller!.updateTaskCollaboration(
        context, item.id!, collaborator.name, collaborator.id);
  }

  TaskPlanController? controller;
  bool isDataLoaded = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isDataLoaded) {
      controller = Provider.of<TaskPlanController>(context, listen: false);
      List<dynamic> args = ModalRoute.of(context)!.settings.arguments as List;
      controller!.tasks.clear();
      controller!.tasks.addAll(args[0]);
      controller!.collaborators.clear();
      args[1].forEach((element) {
        controller!.collaborators.add(Collaborator(
          id: element.id,
          name: element.username,
        ));
      });
      isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.colorThree,
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios)),
      title: Text(
        'Task Assign',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 25,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
      ),
      elevation: 0,
      backgroundColor: Color.fromRGBO(243, 228, 255, 1),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings_ethernet)),
      ],
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildMenuList(),
              ),
              Container(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: _buildPeopleRow()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: controller!.tasks.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12.0,
        );
      },
      itemBuilder: (context, index) {
        final item = controller!.tasks[index];
        return _buildMenuItem(
          item: item,
        );
      },
    );
  }

  Widget _buildMenuItem({
    required Task item,
  }) {
    return LongPressDraggable<Task>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        title: item.taskName!,
      ),
      child: MenuListItem(
        name: item.taskName!,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 20.0,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            controller!.collaborators.map(_buildPersonWithDropZone).toList(),
      ),
    );
  }

  Widget _buildPersonWithDropZone(Collaborator user) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: DragTarget<Task>(
        builder: (context, candidateItems, rejectedItems) {
          return CustomerCart(
            hasItems: user.items.isNotEmpty,
            highlighted: candidateItems.isNotEmpty,
            collaborator: user,
          );
        },
        onAccept: (item) {
          _itemDroppedOnCustomerCart(
            item: item,
            collaborator: user,
          );
        },
      ),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    super.key,
    required this.collaborator,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Collaborator collaborator;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: highlighted ? 1.1 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(22.0),
        color: highlighted
            ? Color.fromARGB(255, 179, 231, 181)
            : Color.fromRGBO(243, 228, 255, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                collaborator.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  child: Visibility(
                    visible: hasItems,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: ListView.builder(
                      itemCount: collaborator.items.length,
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              collaborator.items[index].taskName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 241, 241, 241)),
                            ))),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.isDepressed = false,
  });

  final String name;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      color: AppColors.green,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 35,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 30.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 231, 231, 231)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.title,
  });

  final GlobalKey dragKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: Container(
        key: dragKey,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}

class Collaborator {
  Collaborator({
    required this.id,
    required this.name,
    List<Task>? items,
  }) : items = items ?? [];
  final int id;
  final String name;
  final List<Task> items;
}
