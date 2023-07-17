import 'package:flutask/controllers/project_controller.dart';
import 'package:flutask/helpers/utils/app_space.dart';
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
      await controller!.getCollaborators(context, controller!.projectId!);
      await controller!.getTasks(context, controller!.projectId!);
      isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            kAppBar(
              showBackButton: true,
              title: "Project",
            ),
            AppSpace.spaceH10,
            ElevatedButton(
              onPressed: () {
                showCollaborators(context, size);
              },
              child: Text("Collaborators"),
            ),
            AppSpace.spaceH10,
            ElevatedButton(onPressed: () {}, child: Text("Tasks")),
            AppSpace.spaceH10,
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/task_manager');
                },
                child: Text("Task Plan")),
            AppSpace.spaceH10,
            ElevatedButton(onPressed: () {}, child: Text("Task Trxn")),
          ],
        ),
      )),
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
}
