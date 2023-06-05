import 'package:flutter/material.dart';

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
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kAppBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget kAppBar() {
    return Row(
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
    );
  }
}
