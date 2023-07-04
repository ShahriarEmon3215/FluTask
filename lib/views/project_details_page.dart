import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutter/material.dart';

import '../widgets/kAppBar.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: size.height * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Find user by email",
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            hintText: "example@gmail.com",
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  AppSpace.spaceW10,
                                  Container(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Icon(Icons.search),
                                    ),
                                  )
                                ],
                              ),
                              AppSpace.spaceH10,
                              Expanded(
                                  child: ListView.builder(
                                    itemCount: 3,
                                itemBuilder: (context, index) => Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text("Shahriar Emon"),
                                    subtitle: Text('emon12@gmail.com'),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("Collaborators")),
            AppSpace.spaceH10,
            ElevatedButton(onPressed: () {}, child: Text("Tasks")),
            AppSpace.spaceH10,
            ElevatedButton(onPressed: () {}, child: Text("Task Plan")),
            AppSpace.spaceH10,
            ElevatedButton(onPressed: () {}, child: Text("Task Trxn")),
          ],
        ),
      )),
    );
  }
}
