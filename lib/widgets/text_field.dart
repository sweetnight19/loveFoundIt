import 'package:flutter/material.dart';

TextField textField(placeholder, [obscurePassword = false]) {
  return TextField(
    obscureText: obscurePassword,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: placeholder,
      border: const OutlineInputBorder(),
    ),
  );
}
