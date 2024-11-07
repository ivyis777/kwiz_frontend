import 'dart:ui';

import 'package:Kwiz/core/colors.dart';
import 'package:flutter/material.dart';


class FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? iconColor;

  FilterButton({required this.label, required this.selected, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colours.primaryColor: Colours.CardColour,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 4.5,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          if (iconColor != null)
            CircleAvatar(
              radius: 8,
              backgroundColor: iconColor,
            ),
          if (iconColor != null)
            SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: selected ? Colors.white : Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }
}
