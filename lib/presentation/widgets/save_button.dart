import 'package:Kwiz/core/colors.dart';
import 'package:flutter/material.dart';


class SaveButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final FocusNode? focusNode;
  final double circularRadius;
  final bool isButtonPressed;
  final bool loadingActionRequired;
  final TextStyle textStyle;
  const SaveButton(
      {Key? key,
      required this.title,
      required this.onPress,
      this.focusNode,
      required this.circularRadius,
      required this.isButtonPressed,
      required this.loadingActionRequired,
       required this.textStyle,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: isButtonPressed,
        child: TextButton(
            focusNode: focusNode,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    isButtonPressed == true ? Colours.primaryColor: Colours.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(circularRadius),
                    side: BorderSide(color:  Colours.secondaryColour,))),
            onPressed: onPress,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold))));
  }
}
