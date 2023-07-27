import 'package:flutask/controllers/project_controller.dart';
import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutask/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/kAppBar.dart';

class ProjectDetails extends StatefulWidget {
  ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  void initState() {
    super.initState();
  }

  bool isDataLoaded = false;
  ProjectController? controller;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (!isDataLoaded) {
      controller = Provider.of<ProjectController>(context, listen: false);
      controller!.projectId = ModalRoute.of(context)!.settings.arguments as int;
      print(controller!.projectId);
      await controller!.getCollaborators(context, controller!.projectId!);
      await controller!.getTasks(context, controller!.projectId!);
      isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: bodyUi(size, context),
      floatingActionButton: bottomFloatButton(),
    );
  }

  Widget bodyUi(Size size, BuildContext context) {
    return SafeArea(
        child: Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          kAppBar(
            showBackButton: true,
            title: "Project",
            backPressHandler: () {
              Navigator.pop(context);
            },
          ),
          AppSpace.spaceH10,
          Row(
            children: [
              AppSpace.spaceW10,
              topCardItem("Collaborators", "assets/images/collaborators.png"),
              AppSpace.spaceW10,
              topCardItem("Task Plan", "assets/images/plan.png"),
              AppSpace.spaceW10,
            ],
          ),
          AppSpace.spaceH4,
          Row(
            children: [
              AppSpace.spaceW10,
              topCardItem("Create Task", "assets/images/create.png"),
              AppSpace.spaceW10,
              topCardItem("Project Settings", "assets/images/settings.png"),
              AppSpace.spaceW10,
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Tasks",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black38),
              ),
            ),
          ),
          taskListView(size),
        ],
      ),
    ));
  }

  Widget topCardItem(String label, String imgPath) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (label == "Collaborators") {
            showCollaborators(context, MediaQuery.sizeOf(context));
          } else if (label == "Task Plan") {
            Navigator.pushNamed(context, '/task_plan');
          } else if (label == "Create Task") {
          } else if (label == "Project Settings") {}
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 110, width: 110, child: Image.asset(imgPath)),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskListView(Size size) {
    return Consumer<ProjectController>(
      builder: (context, controller, child) => Container(
        height: size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 236, 236, 236),
        ),
        child: controller.tasks.length != 0
            ? ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  Task task = controller.tasks[index];
                  return taskItem(task);
                },
              )
            : Center(child: Text("No tasks")),
      ),
    );
  }

  Widget taskItem(Task task) {
    
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.play_circle),
        ),
        title: Text(
          task.taskName!,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        subtitle: Row(
          children: [
            Text(
              task.status == null
                  ? task.username != null
                      ? "Assigned to ${task.username}"
                      : "Not assigned yet!"
                  : task.status!,
              style: TextStyle(
                  color: task.status == null ? Colors.black38 : Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showCollaborators(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
            height: size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Add new collaborator by email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54),
                    ),
                  ),
                  AppSpace.spaceH10,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: controller!.emailTextController,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                hintText: "example@gmail.com",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      AppSpace.spaceW10,
                      Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller!.getUserByEmail(
                                context, controller!.emailTextController.text);
                            if (controller!.userForAdd!.email != null) {
                              setState(() {
                                controller!.showSearchedUser = true;
                              });
                            }
                          },
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                  if (controller!.showSearchedUser!)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius:
                            //       BorderRadius.circular(30),
                            // ),
                            child: ListTile(
                              title: Text(controller!.userForAdd!.username!),
                              subtitle: Text(controller!.userForAdd!.email!),
                            ),
                          ),
                        ),
                        AppSpace.spaceW10,
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller!.createCollaboration(context);
                              setState(
                                () {
                                  controller!.showSearchedUser = false;
                                  controller!.userForAdd = User();
                                },
                              );
                            },
                            child: Icon(Icons.add_circle),
                          ),
                        )
                      ],
                    ),
                  AppSpace.spaceH10,
                  Expanded(
                      child: ListView.builder(
                    itemCount: controller!.collaborators.length,
                    itemBuilder: (context, index) {
                      User? user = controller!.collaborators[index];
                      return Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(user.username ?? ""),
                          subtitle: Text(user.email ?? ""),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          );
        });
      },
    );
  }

  FloatingActionButton bottomFloatButton() {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.pushNamed(context, '/tasks',
            arguments: controller!.tasks);
        controller!.getTasks(context, controller!.projectId!);
      },
      label: Row(
        children: [
          Icon(
            Icons.play_circle,
          ),
          AppSpace.spaceW10,
          Text("Task Board"),
        ],
      ),
    );
  }
}
