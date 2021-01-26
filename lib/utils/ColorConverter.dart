import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConverter {
  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    if(hexString == "none") {
      return Colors.grey;
    } else {
      return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
    }
  }
}