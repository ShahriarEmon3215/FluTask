import 'package:flutask/controllers/dashbord_controller.dart';
import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Container(
        height: size.height,
        width: size.width,
        // padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              //child: Image.asset("assets/images/bg.jpg"),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.62,
                width: size.width,
                padding: EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppSpace.spaceH16,
                      Text(
                        "Projects",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ...[0, 1, 2, 3, 4, 5]
                          .map((e) => Consumer<DashboardController>(
                                builder: (context, controller, child) =>
                                    projectCardItem(size),
                              ))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * 0.412,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.backColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  kAppBar(),
                  AppSpace.spaceH10,
                  _topStatusCard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget projectCardItem(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width,
      height: 100,
      padding: EdgeInsets.all(10),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 243, 243, 243)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "FluTask Manage",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              valueNotifier: ValueNotifier(50),
              onGetText: (double value) {
                return Text('${value.toInt()}%');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _topStatusCard(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/task_plan");
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _topStatusCardItem(Color.fromRGBO(189, 255, 223, 1),
                      "12", "Total Contributed"),
                ),
                AppSpace.spaceW10,
                Expanded(
                  child: _topStatusCardItem(Color.fromRGBO(214, 238, 255, 1),
                      "6", "Total Completed Projects"),
                ),
              ],
            ),
            AppSpace.spaceH10,
            Row(
              children: [
                Expanded(
                  child: _topStatusCardItem(Color.fromRGBO(243, 228, 255, 1),
                      "2", "Running Projects"),
                ),
                AppSpace.spaceW10,
                Expanded(
                  child: _topStatusCardItem(
                      Color.fromRGBO(230, 243, 236, 1), "4", "Running Tasks"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _topStatusCardItem(Color color, String value, String label) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          AppSpace.spaceH10,
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color.fromARGB(255, 117, 117, 117)),
          ),
        ],
      ),
    );
  }

  Widget kAppBar() {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                "Shahriar Emon",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Carter One"),
              ),
              subtitle: Text("shahriar3215emon@gmail.com"),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
