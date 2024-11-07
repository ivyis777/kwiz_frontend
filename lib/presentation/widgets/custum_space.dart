import 'package:flutter/material.dart';

class CustomSpace extends StatelessWidget {
  final double? height;
  const CustomSpace({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:height);
  }
}
