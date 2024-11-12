
import 'package:RiddleQing/core/colors.dart';
import 'package:RiddleQing/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLastQuestion;
  final VoidCallback onPressed;

  const SubmitButton({
    Key? key,
    required this.isLastQuestion,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;
    double textFontSize = screenWidth * 0.04;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        isLastQuestion ? "Next" : "Next",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.rubik,
          color: Colours.CardColour,
        ),
      ),
      style: ElevatedButton.styleFrom(
         fixedSize: Size(screenWidth * 0.8, 56),
        backgroundColor: Colours.primaryColor,
          padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
