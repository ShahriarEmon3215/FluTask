import 'package:flutask/helpers/utils/app_space.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  messageAlert(
      {required String? message,
      required BuildContext? context,
      required bool? isError}) {
    showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        content: Container(
          height: 100,
          child: Column(
            children: [
              Text(
                message!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isError! ? Colors.red : Colors.green,
                ),
              ),
              AppSpace.spaceH10,
              Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
