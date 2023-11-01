import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color? answerColor;
  final VoidCallback answerTap; // Use VoidCallback

  Answer({required this.answerText, this.answerColor, required this.answerTap}); // Use 'required' for non-nullable parameters

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: answerColor ?? Colors.white, // Provide a default value for answerColor
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20.0),

        ),
        child: Text(
          answerText,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
