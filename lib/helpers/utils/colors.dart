import 'package:flutter/material.dart';

class AppColors {
  static var backColor = fromHex("#C4E8C2");
  static var cardColor = fromHex("#6BBD99");

  static var green = Colors.green;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
