import 'package:app_new_version_check/app_new_version_check.dart';
import 'package:countup/countup.dart';
import 'package:flutask/controllers/auth_controller.dart';
import 'package:flutask/controllers/dashbord_controller.dart';
import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutask/helpers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Components/project_item_view.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage>
    with TickerProviderStateMixin {
  var controller;
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool? isDataLoaded = false;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isDataLoaded!) {
      check(context);
      controller = ref.read(dashboardProvider.notifier);
      await controller.getProjectList(context);
      await controller.getContributedProjectsList(context);
      isDataLoaded = true;
    }
  }

  check(BuildContext context) async {
    await AppVersion().checkAppUpdate(
      context: context,
      applicationPackageId:
          "com.zamzamit.hishabee", // flutter application package id
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(dashboardProvider);
    var size = MediaQuery.of(context).size;
    var authController = ref.read(authProvider.notifier);
    controller = ref.read(dashboardProvider.notifier);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.colorFour,
        body: bodyUi(size, context, authController, controller),
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
            height: size.height,
            width: size.width,
            color: Colors.white,
            //  child: Image.asset("assets/images/bg.jpg"),
          ),
          Positioned(
              bottom: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  return Container(
                    height: size.height * 0.59,
                    width: size.width,
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                          AppSpace.spaceH4,
                          Container(
                            height: size.height * 0.5,
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...controller.projectList.map(
                                          (project) => ProjectItem(
                                            context: context,
                                            size: size,
                                            project: project,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...controller.contributedProjectList
                                            .map(
                                          (project) => ProjectItem(
                                            context: context,
                                            size: size,
                                            project: project,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
            height: size.height * 0.4,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: const Color.fromARGB(255, 201, 201, 201))
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                kAppBar(authProvider),
                AppSpace.spaceH20,
                _topStatusCard(context),
              ],
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
      height: MediaQuery.sizeOf(context).height * 0.12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Countup(
            begin: 0,
            end: double.parse(value),
            duration: Duration(seconds: 3),
            separator: ',',
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
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                "Shahriar Emon",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Carter One"),
              ),
              subtitle: Text(
                "shahriar3215emon@gmail.com",
                style: TextStyle(
                  color: Colors.black54,
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
