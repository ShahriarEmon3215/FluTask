import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../models/project_model.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem(
      {super.key,
      required this.size,
      required this.context,
      required this.project});

  final BuildContext context;
  final Project project;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/project', arguments: project.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: size.width,
        height: 115,
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 245, 245, 245)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.projectName ?? "Undefined Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Total Task: 05",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
                Text(
                  "Collaborators: 03",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
                Text(
                  "Started On: 05 Sep 2023",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 50,
              width: 50,
              child: SimpleCircularProgressBar(
                progressStrokeWidth: 10,
                backStrokeWidth: 5,
                mergeMode: true,
                maxValue: 100,
                animationDuration: 2,
                valueNotifier: ValueNotifier(50),
                onGetText: (double value) {
                  return Text('${value.toInt()}%');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
