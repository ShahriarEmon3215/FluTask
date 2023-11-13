import 'package:app_new_version_check/app_new_version_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/auth_controller.dart';

class Loading extends ConsumerStatefulWidget {
  @override
  ConsumerState<Loading> createState() => _LoadingState();
}

class _LoadingState extends ConsumerState<Loading> {
  
  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider.notifier).initAuthProvider();
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
