import 'package:flutter/material.dart';

BoxDecoration custom_background() {
  return const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Colors.blue,
      Colors.red,
    ],
  ));
}
