import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

class Loading extends StatelessWidget {
  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FluTask",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
