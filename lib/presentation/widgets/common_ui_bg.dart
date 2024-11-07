import 'package:flutter/material.dart';

class CommonUIBG extends StatelessWidget {
  final Widget widget;

  const CommonUIBG({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
   
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32), 
          ),
          child: this.widget,
        ),
      ),
    );
  }
}