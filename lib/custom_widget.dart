import 'package:flutter/material.dart';

BoxDecoration customBackground() {
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
