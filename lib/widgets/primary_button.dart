import 'package:flutter/material.dart';

import '../color_constants.dart';

ElevatedButton primaryButton(text, [callback]) {
  return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20)),
          backgroundColor:
              MaterialStateProperty.all(PRIMARY_BUTTON_BACKGROUND_COLOR)),
      child: Text(
        text,
        style: const TextStyle(color: PRIMARY_BUTTON_FONT_COLOR),
      ),
      onPressed: callback);
}
