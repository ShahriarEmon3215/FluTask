import 'package:flutter/material.dart';

class AppColors {
  static var colorOne = fromHex("#46A094");
  static var colorTwo = Color.fromARGB(244, 35, 30, 44);
  static var colorThree = fromHex("#AECFA4");
  static var colorFour = fromHex("#C4E8C2");

  static var green = Colors.green;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
