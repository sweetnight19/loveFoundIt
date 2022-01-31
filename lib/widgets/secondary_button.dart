import 'package:flutter/material.dart';

import '../color_constants.dart';

ElevatedButton secondaryButton(text, [callback]) {
  return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white))),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20)),
          backgroundColor:
              MaterialStateProperty.all(secondaryButtonBackgroundColor)),
      child: Text(
        text,
        style: const TextStyle(color: secondaryButtonFontColor),
      ),
      onPressed: callback);
}
