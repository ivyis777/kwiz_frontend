import 'package:flutter/material.dart';

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

void main() {
  Gender male = Gender('Male', Icons.male, false);
  Gender female = Gender('Female', Icons.female, false);
  Gender other = Gender('Other', Icons.help_outline, false); // Using help_outline as an example

  print('Male: ${male.name}, Icon: ${male.icon}, Selected: ${male.isSelected}');
  print('Female: ${female.name}, Icon: ${female.icon}, Selected: ${female.isSelected}');
  print('Other: ${other.name}, Icon: ${other.icon}, Selected: ${other.isSelected}');
}
