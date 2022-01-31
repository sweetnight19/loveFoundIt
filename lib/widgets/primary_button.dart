import 'package:flutter/material.dart';

import '../color_constants.dart';

ElevatedButton primaryButton(text, [callback]) {
  return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: primaryButtonBackgroundColor))),
          backgroundColor:
              MaterialStateProperty.all(primaryButtonBackgroundColor)),
      child: Text(
        text,
        style: const TextStyle(color: primaryButtonFontColor),
      ),
      onPressed: callback);
}
