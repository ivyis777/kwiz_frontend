import 'package:flutter/material.dart';

class InputDecorationHelper {
  static InputDecoration textFieldStyle(
      {String labelText = "", String hintText = ""}) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
      prefixIcon: const Icon(Icons.search),
    );
  }

  static InputDecoration textFieldNewStyle(
      {String labelText = "", String hintText = "", Widget? suffixIcon}) {
    return InputDecoration(
        suffixIcon: suffixIcon,
        isDense: false,
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
        
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0));
  }

  static InputDecoration textFieldNewStyleWithIcon(
      {String labelText = "",
      String hintText = "",
      IconData icon = Icons.calendar_today}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: const OutlineInputBorder(),
      
      // isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
      prefixIcon: Icon(icon),
    );
  }
}
