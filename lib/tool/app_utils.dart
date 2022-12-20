import 'package:flutter/material.dart';

class AppUtil {

  static Color convertHexaColor(String colorhexcode) {
    /* Convert Hexa Color */
    String colornew = '0xFF$colorhexcode';
    colornew = colornew.replaceAll('#', '');
    final colorint = int.parse(colornew);
    return Color(colorint);
  }
}