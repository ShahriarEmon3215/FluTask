import 'package:easy_animated_tabbar/easy_animated_tabbar.dart';
import 'package:flutask/controllers/auth_controller.dart';
import 'package:flutask/controllers/dashbord_controller.dart';
import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../models/project_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var controller = Provider.of<DashboardController>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.colorFour,
        body: bodyUi(size, context, authProvider, controller),
        floatingActionButton: bottomFloatButton(),
      ),
    );
  }

  FloatingActionButton bottomFloatButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Row(
        children: [
          Icon(Icons.create),
          AppSpace.spaceW4,
          Text('Create Project'.toUpperCase())
        ],
      ),
    );
  }

  Widget bodyUi(Size size, BuildContext context, AuthProvider authProvider,
      DashboardController controller) {
    return Container(
      height: size.height,
      width: size.width,
      // padding: EdgeInsets.all(15),
      child: Stack(
        children: [
          Container(
              height: size.height, width: size.width, color: AppColors.colorFour
              //child: Image.asset("assets/images/bg.jpg"),
              ),
          Positioned(
              bottom: 0,
              child: Consumer<DashboardController>(
                builder: (context, controller, child) {
                  return Container(
                    height: size.height * 0.62,
                    width: size.width,
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSpace.spaceH20,
                          SizedBox(
                            height: 40,
                            child: TabBar.secondary(
                              controller: _tabController,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  color: Color.fromARGB(255, 186, 176, 233),
                                  borderRadius: BorderRadius.circular(50)),
                              indicatorPadding: EdgeInsets.zero,
                              indicatorWeight: 1,
                              padding: EdgeInsets.zero,
                              tabs: [
                                Tab(
                                  child: Text(
                                    "My Projects",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Contributions",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpace.spaceH20,
                          Container(
                            height: size.height * 0.5,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...controller.projectList.map(
                                          (project) =>
                                              projectCardItem(size, project),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("data")
                                ]),
                          ),
                          AppSpace.spaceH30,
                        ],
                      ),
                    ),
                  );
                },
              )),
          Container(
            height: size.height * 0.412,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.colorTwo,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Column(
              children: [
                kAppBar(authProvider),
                AppSpace.spaceH10,
                _topStatusCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget projectCardItem(Size size, Project project) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width,
      height: 100,
      padding: EdgeInsets.all(10),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.colorThree),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                project.projectName ?? "Undefined Name",
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
                  child: _topStatusCardItem(
                      Color.fromRGBO(189, 255, 223, 1), "12", "Total Projects"),
                ),
                AppSpace.spaceW10,
                Expanded(
                  child: _topStatusCardItem(Color.fromRGBO(214, 238, 255, 1),
                      "6", "Completed Projects"),
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

  Widget kAppBar(AuthProvider authProvider) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                "Shahriar Emon",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Carter One"),
              ),
              subtitle: Text(
                "shahriar3215emon@gmail.com",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                authProvider.logOut();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
