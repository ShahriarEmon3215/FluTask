import 'dart:math';

import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier{
    final List<Color> _colorList = [
    Color.fromRGBO(253, 234, 236, 1),
    Color.fromRGBO(214, 238, 255, 1),
    Color.fromRGBO(243, 228, 255, 1),
    Color.fromRGBO(253, 234, 253, 1),
    Color.fromRGBO(230, 243, 236, 1),
    Color.fromRGBO(189, 255, 223, 1),
    Color.fromRGBO(235, 220, 183, 1),
  ];

  Color getRandomColor() {
    final random = Random();
    Color? color = _colorList[random.nextInt(_colorList.length)];
    return color;
  }
}