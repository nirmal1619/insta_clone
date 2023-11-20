import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final  Color backgroundColor;
  final Color bordercolor;
  final String text;
  final double widget;
  final Color textcolor;
  const FollowButton({super.key, this.function, required this.backgroundColor, required this.bordercolor, required this.text, required this.textcolor, required this.widget});

  @override
  Widget build(BuildContext context) {

  return TextButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero), // Remove internal padding
    ),
    onPressed: function,
    child: Container(
      width: widget, // Set the width here
      height: 40, // Set the height here
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

  
}