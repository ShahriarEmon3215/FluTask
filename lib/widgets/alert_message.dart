import 'package:flutter/material.dart';

class CustomAlert {
  messageAlert({String? message, BuildContext? context, bool? isError}) {
    return ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(message!),
      backgroundColor: isError! ? Colors.red : Colors.green,
    ));
  }
}
